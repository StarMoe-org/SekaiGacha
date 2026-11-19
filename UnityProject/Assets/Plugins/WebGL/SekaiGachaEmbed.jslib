// 与 WebGLTemplates/SekaiGacha/index.html 中的 window.SekaiGachaHost 配合，协议说明见该文件。
mergeInto(LibraryManager.library, {
  SekaiGachaEmbedded: function () {
    return window.parent !== window ? 1 : 0;
  },
  // 由 GachaEmbed 每帧拉取宿主消息，避免宿主在场景加载前发来的消息丢失。
  SekaiGachaPoll: function () {
    var host = window.SekaiGachaHost;
    if (!host || !host.inbox.length) return null;
    var text = host.inbox.shift();
    var size = lengthBytesUTF8(text) + 1;
    var buffer = _malloc(size);
    stringToUTF8(text, buffer, size);
    return buffer;
  },
  SekaiGachaPost: function (json) {
    var host = window.SekaiGachaHost;
    if (host) host.post(JSON.parse(UTF8ToString(json)));
  },
  // 启动浏览器端 WebP/图片下载与解码（含 Cache Storage 缓存与线路回退），返回任务句柄供协程轮询。
  SekaiGachaStartImageLoad: function (pathPtr, hostsCsvPtr) {
    var assets = window.SekaiGachaAssets;
    if (!assets) return 0;
    var jobs = assets._jobs || (assets._jobs = { nextId: 1, map: {} });
    var id = jobs.nextId++;
    var path = UTF8ToString(pathPtr);
    var hostsCsv = UTF8ToString(hostsCsvPtr);
    var hosts = hostsCsv ? hostsCsv.split(",") : [];
    var job = { state: 0, width: 0, height: 0, status: 0, pixels: null, ptr: 0, len: 0, error: "", released: false };
    jobs.map[id] = job;
    assets.loadImage(path, hosts).then(function (result) {
      if (job.released) return;
      if (result && result.ok && result.pixels) {
        job.width = result.width | 0;
        job.height = result.height | 0;
        job.status = (result.status || 200) | 0;
        job.pixels = result.pixels;
        job.state = 1;
      } else {
        job.status = (result && result.status) ? (result.status | 0) : 0;
        job.error = (result && result.error) ? String(result.error) : "image_load_failed";
        job.state = -1;
      }
    }).catch(function (err) {
      if (job.released) return;
      job.status = 0;
      job.error = String(err && err.message ? err.message : err);
      job.state = -1;
    });
    return id;
  },
  // 轮询图片解码状态：0=进行中，1=完成（像素已拷入 WASM 堆），-1=失败。
  SekaiGachaPollImageLoad: function (handle, outWidthPtr, outHeightPtr, outStatusPtr, outPixelsPtr, outPixelsLenPtr) {
    var assets = window.SekaiGachaAssets;
    var job = assets && assets._jobs ? assets._jobs.map[handle] : null;
    if (!job) {
      HEAP32[outStatusPtr >> 2] = 0;
      return -1;
    }
    if (job.state === 0) return 0;
    if (job.state < 0) {
      HEAP32[outStatusPtr >> 2] = job.status | 0;
      return -1;
    }
    if (!job.ptr && job.pixels) {
      var len = job.pixels.byteLength;
      var ptr = _malloc(len);
      if (!ptr) {
        job.pixels = null;
        job.status = 0;
        job.error = "wasm_oom";
        job.state = -1;
        HEAP32[outStatusPtr >> 2] = 0;
        return -1;
      }
      HEAPU8.set(job.pixels, ptr);
      job.ptr = ptr;
      job.len = len;
      job.pixels = null;
    }
    HEAP32[outWidthPtr >> 2] = job.width | 0;
    HEAP32[outHeightPtr >> 2] = job.height | 0;
    HEAP32[outStatusPtr >> 2] = job.status | 0;
    HEAPU32[outPixelsPtr >> 2] = job.ptr >>> 0;
    HEAP32[outPixelsLenPtr >> 2] = job.len | 0;
    return 1;
  },
  SekaiGachaGetImageError: function (handle) {
    var assets = window.SekaiGachaAssets;
    var job = assets && assets._jobs ? assets._jobs.map[handle] : null;
    var text = (job && job.error) ? String(job.error) : "image_load_failed";
    var size = lengthBytesUTF8(text) + 1;
    var buffer = _malloc(size);
    stringToUTF8(text, buffer, size);
    return buffer;
  },
  SekaiGachaReleaseImageLoad: function (handle) {
    var assets = window.SekaiGachaAssets;
    var jobs = assets && assets._jobs ? assets._jobs : null;
    var job = jobs ? jobs.map[handle] : null;
    if (!job) return;
    job.released = true;
    job.pixels = null;
    if (job.ptr) {
      _free(job.ptr);
      job.ptr = 0;
    }
    delete jobs.map[handle];
  }
});
