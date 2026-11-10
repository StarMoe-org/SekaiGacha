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
  }
});
