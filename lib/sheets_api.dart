import 'package:intl/intl.dart';

import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:googleapis_auth/auth_io.dart';
import '../auth_api.dart' as auth;
import 'package:qr_code/Screens/qr_scanner.dart';
import '../globals.dart';

class SheetsApi {
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

  static const _spreadsheetId = '1vawM4MAWD5NyAONG1HJiub4Jys0_sfe77vYGy-yhkbY';
  static const _range = 'Sheet1!A2:R';

  static Future<Map<String, dynamic>> getSpreadsheetData(
      String qrCodeValue) async {
    final credentials = ServiceAccountCredentials.fromJson(_credentials);
    final scopes = [sheets.SheetsApi.driveScope];
    final client = await clientViaServiceAccount(credentials, scopes);

    try {
      final sheetsApi = sheets.SheetsApi(client);
      final response =
          await sheetsApi.spreadsheets.values.get(_spreadsheetId, _range);

      final rows = response?.values;
      if (rows != null && rows.isNotEmpty) {
        final students = <String, dynamic>{};
        for (final row in rows) {
          if (row.length >= 17) {
            final ApplicationNumber = row[0] as String;
            final Category = row[1] as String;
            final Name = row[2] as String;
            final AadhaarNumber = row[3] as String;
            final InterviewDate = row[4] as String;
            final InterviewTime = row[5] as String;
            final TestVenue = row[6] as String;
            final Image = row[7] as String;
            final Batch = row[8] as String;
            final Panel = row[9] as String;
            final Status = row[10] as String;
            final AppearedWho = row[11] as String;
            final AppearedWhen = row[12] as String;
            final TestWho = row[13] as String;
            final TestWhen = row[14] as String;
            final InterviewedBy = row[15] as String;
            final InterviewedOn = row[16] as String;
            final SerialNumber = row[17] as String;

            if (ApplicationNumber == qrCodeValue) {
              students[ApplicationNumber] = {
                'ApplicationNumber': ApplicationNumber,
                'Category': Category,
                'Name': Name,
                'AadharNumber': AadhaarNumber,
                'InterviewDate': InterviewDate,
                'InterviewTime': InterviewTime,
                'TestVenue': TestVenue,
                'Image': Image,
                'Batch': Batch,
                'Panel': Panel,
                'Status': Status,
                'AppearedWho': AppearedWho,
                'AppearedWhen': AppearedWhen,
                'TestWho': TestWho,
                'TestWhen': TestWhen,
                'InterviewedBy': InterviewedBy,
                'InterviewedOn': InterviewedOn,
                'SerialNumber': SerialNumber,
              };
              break; // Exit the loop if QR code value is found
            }
          }
        }
        return students;
      }
    } catch (e) {
      print('Error retrieving spreadsheet data: $e');
    } finally {
      client.close();
    }

    return {};
  }

  static Future<void> updateAttendance(String qrCodeValue) async {
    final credentials = ServiceAccountCredentials.fromJson(_credentials);
    final scopes = [sheets.SheetsApi.driveScope];
    final client = await clientViaServiceAccount(credentials, scopes);

    try {
      final sheetsApi = sheets.SheetsApi(client);
      final response =
          await sheetsApi.spreadsheets.values.get(_spreadsheetId, _range);

      final rows = response?.values;
      if (rows != null && rows.isNotEmpty) {
        final updatedRows = <List<Object?>>[];
        for (final row in rows) {
          if (row.length >= 17) {
            final ApplicationNumber = row[0] as String;
            final qrCodeUrl =
                row[7] as String; // Get the QR code URL from the row

            if (ApplicationNumber == qrCodeValue) {
              // Update the "Status" column (index 10) to "Present"
              row[10] = 'Present';

              // Update the "Name" column (index 9) with a name
              row[11] = Globals.username;

              // Update the "Time" column (index 11) with the current time
              row[12] = DateFormat('HH:mm:ss').format(DateTime.now());
            }

            // Add the updated row, including the QR code URL, to the list of updated rows
            updatedRows.add(row);
          }
        }

        // Create the value range to update the spreadsheet
        final valueRange = sheets.ValueRange.fromJson({
          'range': _range,
          'majorDimension': 'ROWS',
          'values': updatedRows,
        });

        // Update the spreadsheet values
        await sheetsApi.spreadsheets.values.update(
          valueRange,
          _spreadsheetId,
          _range,
          valueInputOption: 'USER_ENTERED',
        );
      }
    } catch (e) {
      print('Error updating attendance: $e');
    } finally {
      client.close();
    }
  }

  static Future<void> updateTestAttendance(String qrCodeValue) async {
    final credentials = ServiceAccountCredentials.fromJson(_credentials);
    final scopes = [sheets.SheetsApi.driveScope];
    final client = await clientViaServiceAccount(credentials, scopes);

    try {
      final sheetsApi = sheets.SheetsApi(client);
      final response =
          await sheetsApi.spreadsheets.values.get(_spreadsheetId, _range);

      final rows = response?.values;
      if (rows != null && rows.isNotEmpty) {
        final updatedRows = <List<Object?>>[];
        for (final row in rows) {
          if (row.length >= 17) {
            final ApplicationNumber = row[0] as String;
            final qrCodeUrl =
                row[7] as String; // Get the QR code URL from the row

            if (ApplicationNumber == qrCodeValue) {
              // Update the "Status" column (index 10) to "Test Attended"
              row[10] = 'Test Attended';

              // Update the "Name" column (index 12) with a name
              row[13] = Globals.username;

              // Update the "Time" column (index 13) with the current time
              row[14] = DateFormat('HH:mm:ss').format(DateTime.now());
            }

            // Add the updated row, including the QR code URL, to the list of updated rows
            updatedRows.add(row);
          }
        }

        // Create the value range to update the spreadsheet
        final valueRange = sheets.ValueRange.fromJson({
          'range': _range,
          'majorDimension': 'ROWS',
          'values': updatedRows,
        });

        // Update the spreadsheet values
        await sheetsApi.spreadsheets.values.update(
          valueRange,
          _spreadsheetId,
          _range,
          valueInputOption: 'USER_ENTERED',
        );
      }
    } catch (e) {
      print('Error updating test attendance: $e');
    } finally {
      client.close();
    }
  }

  static Future<void> updateInterviewAttendance(String qrCodeValue) async {
    final credentials = ServiceAccountCredentials.fromJson(_credentials);
    final scopes = [sheets.SheetsApi.driveScope];
    final client = await clientViaServiceAccount(credentials, scopes);

    try {
      final sheetsApi = sheets.SheetsApi(client);
      final response =
          await sheetsApi.spreadsheets.values.get(_spreadsheetId, _range);

      final rows = response?.values;
      if (rows != null && rows.isNotEmpty) {
        final updatedRows = <List<Object?>>[];
        for (final row in rows) {
          if (row.length >= 17) {
            final ApplicationNumber = row[0] as String;
            final qrCodeUrl =
                row[7] as String; // Get the QR code URL from the row

            if (ApplicationNumber == qrCodeValue) {
              // Update the "Status" column (index 9) to "Interview Attended"
              row[10] = 'Interview Attended';

              // Update the "Name" column (index 13) with a name
              row[15] = Globals.username;

              // Update the "InterviewedBy" column (index 14) with the current time
              row[16] = DateFormat('HH:mm:ss').format(DateTime.now());
            }

            // Add the updated row, including the QR code URL, to the list of updated rows
            updatedRows.add(row);
          }
        }

        // Create the value range to update the spreadsheet
        final valueRange = sheets.ValueRange.fromJson({
          'range': _range,
          'majorDimension': 'ROWS',
          'values': updatedRows,
        });

        // Update the spreadsheet values
        await sheetsApi.spreadsheets.values.update(
          valueRange,
          _spreadsheetId,
          _range,
          valueInputOption: 'USER_ENTERED',
        );
      }
    } catch (e) {
      print('Error updating interview attendance: $e');
    } finally {
      client.close();
    }
  }
}
