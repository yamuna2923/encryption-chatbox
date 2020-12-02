import 'package:rsa_util/rsa_util.dart';

class MyRSA{

  Future<Map<String, dynamic>> generateKeys()async{
    List<String> keys = RSAUtil.generateKeys(1024);
    final pubKey = keys[0];
    final priKey = keys[1];

    return {
      "publicKey": pubKey,
      "privateKey": priKey
    };
  }

  rsaEnc(String pubKey, String priKey, String message){
    RSAUtil rsa = RSAUtil.getInstance(pubKey, priKey);
    
    var jiami = rsa.encryptByPublicKey(message);
    return jiami;
  }

  rsaDec(String pubKey, String priKey, String encString){
    RSAUtil rsa = RSAUtil.getInstance(pubKey, priKey);
    
    var jiemi = rsa.decryptByPrivateKey(encString);
    return jiemi;
  }
  
}