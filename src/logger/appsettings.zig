// {
//   "Logging": {
//     "LogLevel": {
//       "Default": "Information",
//       "MyApp.Http": "Debug",
//       "MyApp.Db": "Warning"
//     },
//     "Sinks": {
//       "Console": {
//         "Enabled": true,
//         "Format": "json",          // "text" | "json"
//         "IncludeScopes": true
//       },
//       "File": {
//         "Enabled": false,
//         "Path": "logs/app.log",
//         "Format": "json"
//       }
//     },
//     "Redaction": {
//       "Keys": ["password", "token", "authorization"]
//     }
//   }
// }

