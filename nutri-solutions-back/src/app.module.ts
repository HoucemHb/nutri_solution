import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { RecipeModule } from './recipe/recipe.module';
import { UserModule } from './user/user.module';
import { PlanningModule } from './planning/planning.module';
import { TypeOrmModule } from '@nestjs/typeorm';
import { FileUploadController } from './common/upload/upload.controller';
import { UploadModule } from './common/upload/upload.module';
import { AuthModule } from './auth/auth.module';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { MailerModule } from '@nestjs-modules/mailer';
import { join } from 'path';
import { HandlebarsAdapter } from '@nestjs-modules/mailer/dist/adapters/handlebars.adapter';
import { ReservedSlotSubscriber } from './planning/reserved-slot/reserved-slot.subscriber';
import { ScheduleModule } from '@nestjs/schedule';
import { MessagesModule } from './messenger/messenger.module';
// import { MonitoringModule } from './monitoring/monitoring.module';

@Module({
  imports: [
    ScheduleModule.forRoot(),
    RecipeModule,
    UserModule,
    PlanningModule,
    MessagesModule,
    TypeOrmModule.forRootAsync({
      imports: [ConfigModule],
      inject: [ConfigService],

      useFactory: (configService: ConfigService) => ({
        type: 'mysql',
        host: configService.get<string>('DB_HOST'),
        port: configService.get<number>('DB_PORT'),
        username: configService.get<string>('DB_USERNAME'),
        password: configService.get<string>('DB_PASSWORD'),
        database: configService.get<string>('DB_DATABASE'),
        autoLoadEntities: true,
        synchronize: true,
        logging: true,
        subscribers: [ReservedSlotSubscriber],
      }),
    }),
    MailerModule.forRoot({
      transport: {
        host: 'smtp.gmail.com',
        port: 465,
        ignoreBadCertificate: true, //!!! Ignore bad certificate ???
        secure: true, // Use SSL
        auth: {
          user: 'houcem96.hh@gmail.com',
          pass: 'sdhc snhz txmj dhom', // Use an App Password for better security
        },
        tls: {
          rejectUnauthorized: false, // Allow self-signed certificates
        },
      },
      defaults: {
        from: '"NutriSolutions Team" <houcem96.hh@gmail.com>', // Default sender address
      },
      template: {
        dir: join(__dirname, '..', 'src/common/email', 'templates'),
        adapter: new HandlebarsAdapter(), // Use Handlebars as a template engine
        options: {
          strict: true,
        },
      },
    }),
    UploadModule,
    AuthModule,
    ConfigModule.forRoot({ isGlobal: true }),
    ScheduleModule.forRoot(),
    // MonitoringModule,
  ],
  controllers: [AppController, FileUploadController],
  providers: [AppService],
})
export class AppModule {}

// import 'package:mailer/mailer.dart';
// import 'package:mailer/smtp_server.dart';

// Future<void> sendEmailTemplate(
//     {required String recipient,
//     required String subject,
//     required String content}) async {
//   String username = 'houcem96.hh@gmail.com'; // Your Gmail address
//   String appSpecificPassword = 'sdhc snhz txmj dhom';
//   final smtpServer = SmtpServer(
//     'smtp.gmail.com',
//     port: 465, //587 ki yebda ssl false
//     username: username,
//     password: appSpecificPassword,
//     ignoreBadCertificate: true, //!!! Ignore bad certificate ???
//     ssl: true,
//   );
//   // Create a new email message
//   final message = Message()
//     ..from = const Address('houcem96.hh@gmail.com', 'noreply')
//     ..recipients.add(recipient)
//     ..subject = subject
//     ..html = """
//     <!DOCTYPE html>
//     <html>
//     <head>
//         <style>
//             body {
//                 font-family: Arial, sans-serif;
//             }
//             .container {
//                 padding: 20px;
//                 border: 1px solid #ccc;
//                 margin: 20px auto;
//                 max-width: 600px;
//             }
//             .header {
//                 background-color: #f2f2f2;
//                 padding: 10px;
//                 text-align: center;
//             }
//             .content {
//                 margin-top: 20px;
//             }
//             .footer {
//                 margin-top: 20px;
//                 font-size: 0.9em;
//                 color: #666;
//                 text-align: center;
//             }
//         </style>
//     </head>
//     <body>
//         <div class="container">
//             <div class="header">
//                 <h2>New Reservation Notification</h2>
//             </div>
//             $content
//             <div class="footer">
//                 <p>Thank you for using our service.</p>
//             </div>
//         </div>
//     </body>
//     </html>
//     """;

//   try {
//     // Send the email
//     final sendReport = await send(message, smtpServer);
//     print('Message sent: $sendReport');
//   } on MailerException catch (e) {
//     print('Message not sent. ${e.toString()}');
//   }
// }
