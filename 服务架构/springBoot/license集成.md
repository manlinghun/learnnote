# springboot集成License

## 准备生成cer证书、私钥、公钥

1. 生成私钥库

    执行以下命令，此时会在当前目录中生成privateKeys.keystore 文件

~~~sh

keytool -genkeypair -alias license -keyalg RSA -keysize 1024 -validity 3650 -keystore license.keystore -storepass "haohaoshangban996" -keypass "shangbanzhenlei996" -dname "CN=localhost,OU=localhost,O=localhost,L=SH,ST=SH,C=CN"

~~~

* genkeypair: 生成密钥对
* alias: 私钥库别名
* keyalg: 密钥算法
* keysize: 密钥长度
* validity: 证书有效期
* keystore: 私钥库文件名
* storepass: 私钥库密码
* keypass: 私钥密码
* dname: 证书信息

2. 把私匙库内的公匙导出到一个文件当中

    执行以下命令，此时会在当前目录中生成 certfile.cer 文件

~~~sh

keytool -exportcert -alias license -keystore license.keystore -storepass "haohaoshangban996" -file certfile.cer

~~~

* export: 导出证书
* alias: 私钥库别名
* keystore: 私钥库文件名
* storepass: 私钥库密码
* file: 导出证书文件名

3.  再把这个证书文件导入到公匙库
   
~~~sh

keytool -import -alias publicCert -file certfile.cer -keystore publicCerts.keystore -storepass "haohaoshangban996" 

~~~

* import: 导入证书
* alias: 公匙库别名
* file: 导入证书文件名
* keystore: 公钥文件名称
* storepass: 指定私钥库的密码


4. 代碼

    1. CustomKeyStoreParam
    2. LicenseCreator
    3. LicenseCreatorController
    4. LicenseCreatorParam
    5. ApiConfig
    6. LicenseCheckInterceptor
    7. AbstractServerInfos
    8. LicenseBaseModel
    9. LicenseCheckModel
    10. LinuxServerInfos
    11. WindowsServerInfos
    12. CustomLicenseManager
    13. LicenseCheckListener
    14. LicenseManagerHolder
    15. LicenseVerify
    16. LicenseVerifyController
    17. LicenseVerifyParam
