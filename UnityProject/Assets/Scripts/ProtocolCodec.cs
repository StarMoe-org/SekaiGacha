using System;
using System.IO;
using System.Text;
using System.Collections.Generic;
using System.Security.Cryptography;
namespace SekaiGacha {
public static class ProtocolCodec {
private static readonly byte[] Key = Encoding.ASCII.GetBytes("g2fcC0ZczN9MTJ61");
private static readonly byte[] IV = Encoding.ASCII.GetBytes("msx3IV0i9XE5uYZ1");
        public static byte[] Crypt(byte[] data, bool encrypt)
        {
            using (var aes = Aes.Create())
            {
                aes.Key = Key; aes.IV = IV; aes.Mode = CipherMode.CBC; aes.Padding = PaddingMode.PKCS7;
                using (var transform = encrypt ? aes.CreateEncryptor() : aes.CreateDecryptor())
                    return transform.TransformFinalBlock(data, 0, data.Length);
            }
        }

        // 解析启动及主数据响应；未知格式直接报错。
        public sealed class MessageReader
        {
            private readonly byte[] bytes;
            private int offset;
            public MessageReader(byte[] value) { bytes = value; }
            private ulong Number(int count) { ulong n=0; while(count-- > 0) n=(n<<8)|bytes[offset++]; return n; }
            private string Text(int count) { var value=Encoding.UTF8.GetString(bytes,offset,count); offset+=count; return value; }
            private byte[] Binary(int count) { var result=new byte[count]; Buffer.BlockCopy(bytes,offset,result,0,count); offset+=count;return result; }
            private object Floating(int count) { var value=Binary(count); if(BitConverter.IsLittleEndian)System.Array.Reverse(value); return count==4 ? (object)BitConverter.ToSingle(value,0) : BitConverter.ToDouble(value,0); }
            private object Array(int count) { var result=new object[count]; for(int i=0;i<count;i++) result[i]=Read(); return result; }
            private object Map(int count)
            {
                var result=new Dictionary<string,object>();
                for(int i=0;i<count;i++) { var key=(string)Read(); result.Add(key,Read()); }
                return result;
            }
            public object Read()
            {
                byte b=bytes[offset++];
                if(b<0x80) return (long)b;
                if(b>=0xe0) return (long)(sbyte)b;
                if((b&0xe0)==0xa0) return Text(b&31);
                if((b&0xf0)==0x80) return Map(b&15);
                if((b&0xf0)==0x90) return Array(b&15);
                switch(b)
                {
                    case 0xc0:return null;
                    case 0xc2:return false;
                    case 0xc3:return true;
                    case 0xc4:return Binary((int)Number(1));
                    case 0xc5:return Binary((int)Number(2));
                    case 0xc6:return Binary((int)Number(4));
                    case 0xca:return Floating(4);
                    case 0xcb:return Floating(8);
                    case 0xcc:return (long)Number(1);
                    case 0xcd:return (long)Number(2);
                    case 0xce:return (long)Number(4);
                    case 0xcf:return Number(8);
                    case 0xd0:return (long)(sbyte)Number(1);
                    case 0xd1:return (long)(short)Number(2);
                    case 0xd2:return (long)(int)Number(4);
                    case 0xd3:return (long)Number(8);
                    case 0xd9:return Text((int)Number(1));
                    case 0xda:return Text((int)Number(2));
                    case 0xdb:return Text((int)Number(4));
                    case 0xdc:return Array((int)Number(2));
                    case 0xdd:return Array((int)Number(4));
                    case 0xde:return Map((int)Number(2));
                    case 0xdf:return Map((int)Number(4));
                    default:throw new InvalidDataException("Unsupported startup MessagePack tag: "+b.ToString("x2"));
                }
            }
        }
}}
