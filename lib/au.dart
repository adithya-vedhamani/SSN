import 'package:intl/intl.dart';

import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:googleapis_auth/auth_io.dart';
import '../auth_api.dart' as auth;
import 'package:qr_code/Screens/qr_scanner.dart';
import '../globals.dart';


class SheetCred{


  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "qrcode-389011",
  "private_key_id": "17f3dbdb5da24f0c91442d9a2b55a343bd3066f8",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCU95xpvM3u7pba\nmDvqbdtlt+RxvO0WOcB0uB8ZIMGwqU8z4SBsMIGn9f0xxDmejjz/eNGAaJxx3hRN\nHYfDm5yd93rYyQzws4R3B/Vkf+SJuxA3T2BgzOmWMd68RCUcSyevdpzP00x5cYe6\nlOzmoyZrTOzdSmy1eQ7da6qNgPlia3fK3HLq2gk6FWjTqybnPWAJCYTrRgPTABct\nVTy8bYswLHmHjf7gH0ZmgEWIY3xNejAhdzhRGXdLwDDQ64YFIeeNApLAn5gVqduR\n8eB2kP8PBB1xRfRKNV9dMbrRADYwEvXOT8mlwdUUOMVFt2YWR6uCBVNF/iowv0/D\n4Kqkn6ivAgMBAAECggEACIo8Pc8uN4hKPqrjWHIToolM/+MJ7ONcfKe0V+W9JOPe\nUtLEeV9VUR80wWsgUIFgAgqKz1bWWfkwACgoVdbwchmAQeuFiEqj7/Au9opJPEbs\nmMPxejf7gvnfhoezk70qDJDH6Z3EvXuVzktmXDLpnqIkCOwQ2MOuNGEzpfWvllKm\nrgEPvp2gsVdq2wiLu4c66CEjWevTW5mwtFsScki2O5R9GheES88OcJL24gWjvuVV\niYon2o/JNc/kn/tfZLoeRdGI5KMSJZ3sJn50QpdCGA7tYdam/W9lRZxU+h5hPhtj\nMutIzXR8IMdYMAuolb+K+7dBbzN4CT6ZdKoMJDj5EQKBgQDMqpf+0zP6F4NFRwFQ\nQ3/I5gevdBmLj3WjcXFiHm2iFmAZtL97DIw+urwyMFrIBKj0ca6wzqLk/CEKOTf/\n8S/5O5jXeEgzX+LVXV7gKeOR4NAG+aH6/tdsXjS7h0uDOlbSF4QPaHpjixbm1/d6\nbgwMf8RymBnHi7epuVNpMdBOPwKBgQC6VKKcDoGoztlzskL+aBFzqsL27IPg0b2o\nPpfjHDGFO2HGMCBziHLwzUhVbLnSzsVAlmjKIGrMnBekkvIHMSXmSDbDiTX8kb3T\n8Gi0VirzYh93b7a5LX8VhV59SpuztdcWacKw42ENAEQcPm6HLJFlwWr0v67CKnmd\nmfe75pTpkQKBgHpkqnDhrPuqg/4x8D8nnottxLrQG1ayfA86ECw1NirwZpf412mm\nn1gEI/d/o0pqPv+v3GAvsoptnPSYMz0D50SMt2JjtAnFFcmzBMHZSxY58y24q32G\nWR2dWLustSPNB46sMXVlbYuJ6jAyhvTYSqxO3BQLkZ8blsIQ6ijGeWPRAoGAW9D0\nx/2F+s7i7FX9GSvi3aJZrB9j5Na1pEAjzC/KXyKhzW1NsGCecvZVHHMVJkHphSgY\nvvE2b1jDdb9LMCwRxuXyxmvIhIq0hclDbwm+5GuHoe0Uly9KHiq4IvkuvGFweYTo\nAQ4qdqOY7Gn/QPC/POsQb0Y9MUSI5RZHsvmui2ECgYEAoxgKERiPTU1lTcWbuRA+\naRb2NPSv77+W0Z9yiyZBCCKoS+EEYDmTXRSH57rvev8x9pjvkGPdCZN1cR4QY0RG\nqBP3rTIhSSPnpCTr6mX8Tq5eLy9LiIGLM7z0Rz0U1XbLA+05P124R2ewWBROe+SW\nvw6Uv3dmJ0OotYPnKXou4jM=\n-----END PRIVATE KEY-----\n",
  "client_email": "qrcode@qrcode-389011.iam.gserviceaccount.com",
  "client_id": "106691019817219857675",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/qrcode%40qrcode-389011.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}

''';

static dynamic client = null;
static final SheetCred _sheetCred = SheetCred._internal();
factory SheetCred(){
  return _sheetCred;

}
SheetCred._internal();

getClient(){

   final credentials = ServiceAccountCredentials.fromJson(_credentials);
   final scopes = [sheets.SheetsApi.driveScope];
   return clientViaServiceAccount(credentials, scopes);
}
 getSheetClient() {
  if(client == null){
    client =  getClient();
      }
  return client;
}
}
