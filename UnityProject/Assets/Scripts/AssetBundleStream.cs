using System;
using System.IO;
namespace SekaiGacha {
// 保留原四字节前缀及前 128 字节逐组取反规则，补齐非对齐读取。
public sealed class AssetBundleStream : Stream {
    private readonly FileStream stream;
    public AssetBundleStream(FileStream fileStream){stream=fileStream;Position=0;}
    public override bool CanRead=>stream.CanRead;
    public override bool CanSeek=>stream.CanSeek;
    public override bool CanWrite=>false;
    public override long Length=>stream.Length-4;
    public override long Position {get=>stream.Position-4;set=>stream.Position=value+4;}
    public override int Read(byte[] buffer,int offset,int count){
        long position=Position;
        int read=stream.Read(buffer,offset,count);
        for(int i=0;i<read && position+i<128;i++)
            if((position+i)%8<5)buffer[offset+i]^=0xff;
        return read;
    }
    public override int ReadByte(){var one=new byte[1];return Read(one,0,1)==0?-1:one[0];}
    public override long Seek(long offset,SeekOrigin origin){stream.Seek(origin==SeekOrigin.Begin?offset+4:offset,origin);return Position;}
    public override void Flush()=>stream.Flush();
    public override void SetLength(long value)=>throw new NotSupportedException();
    public override void Write(byte[] buffer,int offset,int count)=>throw new NotSupportedException();
    protected override void Dispose(bool disposing){if(disposing)stream.Dispose();base.Dispose(disposing);}
}
}
