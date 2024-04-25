import 'package:capstone/journalmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:capstone/face_database_service.dart';
import 'package:capstone/store_faces.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'database_service.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {

  String emotionSummarySvg = '''<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="500" zoomAndPan="magnify" viewBox="0 0 375 374.999991" height="500" preserveAspectRatio="xMidYMid meet" version="1.0"><defs><g/><clipPath id="5f36a6ca8f"><path d="M 187.5 0 C 83.945312 0 0 83.945312 0 187.5 C 0 291.054688 83.945312 375 187.5 375 C 291.054688 375 375 291.054688 375 187.5 C 375 83.945312 291.054688 0 187.5 0 Z M 187.5 0 " clip-rule="nonzero"/></clipPath></defs><g clip-path="url(#5f36a6ca8f)"><rect x="-37.5" width="450" fill="#dceffd" y="-37.499999" height="449.999989" fill-opacity="1"/></g><g fill="#000000" fill-opacity="1"><g transform="translate(69.552086, 126.771407)"><g><path d="M 14.90625 -43.015625 L -7.390625 -18.6875 C -4.160156 -16.132812 -0.65625 -15.054688 3.125 -15.453125 C 6.914062 -15.847656 10.28125 -17.644531 13.21875 -20.84375 C 14.875 -22.644531 16.070312 -24.597656 16.8125 -26.703125 C 17.550781 -28.804688 17.800781 -30.988281 17.5625 -33.25 L 22.125 -33.125 C 22.5 -30.40625 22.203125 -27.707031 21.234375 -25.03125 C 20.273438 -22.363281 18.734375 -19.867188 16.609375 -17.546875 C 13.867188 -14.566406 10.804688 -12.503906 7.421875 -11.359375 C 4.035156 -10.222656 0.628906 -10.039062 -2.796875 -10.8125 C -6.234375 -11.59375 -9.367188 -13.28125 -12.203125 -15.875 C -15.046875 -18.476562 -17.023438 -21.425781 -18.140625 -24.71875 C -19.265625 -28.007812 -19.460938 -31.3125 -18.734375 -34.625 C -18.003906 -37.9375 -16.40625 -40.9375 -13.9375 -43.625 C -11.46875 -46.3125 -8.625 -48.148438 -5.40625 -49.140625 C -2.195312 -50.128906 1.078125 -50.207031 4.421875 -49.375 C 7.765625 -48.539062 10.875 -46.804688 13.75 -44.171875 Z M -10.5625 -40.515625 C -13.125 -37.710938 -14.382812 -34.539062 -14.34375 -31 C -14.300781 -27.46875 -12.957031 -24.257812 -10.3125 -21.375 L 8.59375 -41.984375 C 5.476562 -44.359375 2.160156 -45.414062 -1.359375 -45.15625 C -4.890625 -44.894531 -7.957031 -43.347656 -10.5625 -40.515625 Z M -10.5625 -40.515625 "/></g></g></g><g fill="#000000" fill-opacity="1"><g transform="translate(90.972753, 96.245142)"><g><path d="M 33.546875 -60.5 C 38.003906 -62.664062 42.125 -63.082031 45.90625 -61.75 C 49.695312 -60.425781 52.804688 -57.269531 55.234375 -52.28125 L 65.234375 -31.703125 L 60.4375 -29.375 L 50.671875 -49.46875 C 48.878906 -53.164062 46.625 -55.546875 43.90625 -56.609375 C 41.195312 -57.679688 38.21875 -57.429688 34.96875 -55.859375 C 31.28125 -54.066406 28.929688 -51.519531 27.921875 -48.21875 C 26.910156 -44.925781 27.378906 -41.28125 29.328125 -37.28125 L 38.375 -18.65625 L 33.59375 -16.328125 L 23.828125 -36.421875 C 22.035156 -40.117188 19.78125 -42.5 17.0625 -43.5625 C 14.34375 -44.632812 11.34375 -44.375 8.0625 -42.78125 C 4.414062 -41.007812 2.078125 -38.46875 1.046875 -35.15625 C 0.015625 -31.851562 0.472656 -28.203125 2.421875 -24.203125 L 11.46875 -5.578125 L 6.671875 -3.25 L -10.578125 -38.734375 L -5.984375 -40.96875 L -2.828125 -34.484375 C -2.617188 -37.242188 -1.675781 -39.753906 0 -42.015625 C 1.6875 -44.285156 3.988281 -46.128906 6.90625 -47.546875 C 9.875 -48.992188 12.753906 -49.613281 15.546875 -49.40625 C 18.347656 -49.207031 20.890625 -48.140625 23.171875 -46.203125 C 23.335938 -49.179688 24.320312 -51.925781 26.125 -54.4375 C 27.925781 -56.945312 30.398438 -58.96875 33.546875 -60.5 Z M 33.546875 -60.5 "/></g></g></g><g fill="#000000" fill-opacity="1"><g transform="translate(154.4674, 66.818745)"><g><path d="M 23.515625 -1.296875 C 19.722656 -1.023438 16.242188 -1.640625 13.078125 -3.140625 C 9.921875 -4.640625 7.359375 -6.851562 5.390625 -9.78125 C 3.429688 -12.707031 2.316406 -16.085938 2.046875 -19.921875 C 1.765625 -23.765625 2.390625 -27.265625 3.921875 -30.421875 C 5.460938 -33.585938 7.691406 -36.128906 10.609375 -38.046875 C 13.523438 -39.960938 16.878906 -41.054688 20.671875 -41.328125 C 24.460938 -41.597656 27.941406 -40.988281 31.109375 -39.5 C 34.273438 -38.019531 36.820312 -35.820312 38.75 -32.90625 C 40.6875 -29.988281 41.796875 -26.609375 42.078125 -22.765625 C 42.347656 -18.929688 41.726562 -15.425781 40.21875 -12.25 C 38.71875 -9.082031 36.503906 -6.53125 33.578125 -4.59375 C 30.660156 -2.664062 27.304688 -1.566406 23.515625 -1.296875 Z M 23.171875 -6 C 25.972656 -6.195312 28.4375 -7.007812 30.5625 -8.4375 C 32.6875 -9.875 34.289062 -11.804688 35.375 -14.234375 C 36.457031 -16.671875 36.894531 -19.382812 36.6875 -22.375 C 36.46875 -25.363281 35.648438 -27.988281 34.234375 -30.25 C 32.816406 -32.507812 30.957031 -34.191406 28.65625 -35.296875 C 26.351562 -36.410156 23.800781 -36.867188 21 -36.671875 C 18.207031 -36.472656 15.742188 -35.660156 13.609375 -34.234375 C 11.484375 -32.804688 9.867188 -30.875 8.765625 -28.4375 C 7.660156 -26 7.21875 -23.285156 7.4375 -20.296875 C 7.644531 -17.304688 8.46875 -14.679688 9.90625 -12.421875 C 11.34375 -10.171875 13.210938 -8.488281 15.515625 -7.375 C 17.828125 -6.257812 20.378906 -5.800781 23.171875 -6 Z M 23.171875 -6 "/></g></g></g><g fill="#000000" fill-opacity="1"><g transform="translate(195.398653, 64.176906)"><g><path d="M 28.21875 2.1875 C 27.082031 2.914062 25.75 3.394531 24.21875 3.625 C 22.6875 3.863281 21.128906 3.851562 19.546875 3.59375 C 15.898438 2.988281 13.25 1.539062 11.59375 -0.75 C 9.945312 -3.050781 9.421875 -6.003906 10.015625 -9.609375 L 13.875 -33.15625 L 6.921875 -34.296875 L 7.640625 -38.734375 L 14.59375 -37.59375 L 16 -46.09375 L 21.25 -45.234375 L 19.84375 -36.734375 L 31.6875 -34.78125 L 30.96875 -30.34375 L 19.125 -32.296875 L 15.3125 -9.046875 C 14.9375 -6.722656 15.226562 -4.859375 16.1875 -3.453125 C 17.15625 -2.054688 18.722656 -1.179688 20.890625 -0.828125 C 21.972656 -0.648438 23.046875 -0.648438 24.109375 -0.828125 C 25.179688 -1.015625 26.140625 -1.363281 26.984375 -1.875 Z M 28.21875 2.1875 "/></g></g></g><g fill="#000000" fill-opacity="1"><g transform="translate(221.516515, 68.548061)"><g><path d="M 19.28125 -35.21875 L 24.34375 -33.5625 L 12.125 3.953125 L 7.0625 2.296875 Z M 24.515625 -42.578125 C 23.460938 -42.921875 22.695312 -43.5625 22.21875 -44.5 C 21.738281 -45.445312 21.660156 -46.425781 21.984375 -47.4375 C 22.296875 -48.382812 22.921875 -49.097656 23.859375 -49.578125 C 24.804688 -50.054688 25.804688 -50.125 26.859375 -49.78125 C 27.910156 -49.4375 28.679688 -48.800781 29.171875 -47.875 C 29.660156 -46.957031 29.75 -46.019531 29.4375 -45.0625 C 29.101562 -44.019531 28.460938 -43.257812 27.515625 -42.78125 C 26.566406 -42.300781 25.566406 -42.234375 24.515625 -42.578125 Z M 24.515625 -42.578125 "/></g></g></g><g fill="#000000" fill-opacity="1"><g transform="translate(236.499907, 71.458939)"><g><path d="M 20.28125 11.96875 C 16.96875 10.09375 14.414062 7.648438 12.625 4.640625 C 10.832031 1.640625 9.929688 -1.617188 9.921875 -5.140625 C 9.910156 -8.660156 10.851562 -12.09375 12.75 -15.4375 C 14.65625 -18.78125 17.125 -21.34375 20.15625 -23.125 C 23.1875 -24.914062 26.441406 -25.796875 29.921875 -25.765625 C 33.410156 -25.734375 36.8125 -24.78125 40.125 -22.90625 C 43.425781 -21.019531 45.984375 -18.582031 47.796875 -15.59375 C 49.609375 -12.613281 50.507812 -9.367188 50.5 -5.859375 C 50.488281 -2.347656 49.53125 1.078125 47.625 4.421875 C 45.726562 7.765625 43.273438 10.332031 40.265625 12.125 C 37.253906 13.925781 33.992188 14.820312 30.484375 14.8125 C 26.984375 14.800781 23.582031 13.851562 20.28125 11.96875 Z M 22.625 7.859375 C 25.050781 9.242188 27.546875 9.929688 30.109375 9.921875 C 32.679688 9.921875 35.085938 9.207031 37.328125 7.78125 C 39.578125 6.363281 41.441406 4.347656 42.921875 1.734375 C 44.410156 -0.867188 45.191406 -3.5 45.265625 -6.15625 C 45.347656 -8.820312 44.734375 -11.257812 43.421875 -13.46875 C 42.117188 -15.675781 40.253906 -17.472656 37.828125 -18.859375 C 35.390625 -20.242188 32.890625 -20.929688 30.328125 -20.921875 C 27.765625 -20.921875 25.347656 -20.210938 23.078125 -18.796875 C 20.804688 -17.378906 18.925781 -15.367188 17.4375 -12.765625 C 15.957031 -10.148438 15.191406 -7.507812 15.140625 -4.84375 C 15.085938 -2.175781 15.710938 0.257812 17.015625 2.46875 C 18.316406 4.675781 20.1875 6.472656 22.625 7.859375 Z M 22.625 7.859375 "/></g></g></g><g fill="#000000" fill-opacity="1"><g transform="translate(271.751235, 89.966921)"><g><path d="M 47.78125 -7.359375 C 51.1875 -3.773438 52.851562 0.0664062 52.78125 4.171875 C 52.707031 8.273438 50.671875 12.21875 46.671875 16 L 30.078125 31.734375 L 26.421875 27.875 L 42.640625 12.5 C 45.617188 9.675781 47.179688 6.78125 47.328125 3.8125 C 47.472656 0.84375 46.238281 -2.019531 43.625 -4.78125 C 40.695312 -7.863281 37.460938 -9.429688 33.921875 -9.484375 C 30.390625 -9.546875 27.015625 -8.050781 23.796875 -5 L 8.765625 9.25 L 5.109375 5.390625 L 33.734375 -21.75 L 37.25 -18.046875 L 31.96875 -13.046875 C 34.707031 -13.640625 37.441406 -13.457031 40.171875 -12.5 C 42.898438 -11.550781 45.4375 -9.835938 47.78125 -7.359375 Z M 47.78125 -7.359375 "/></g></g></g><g fill="#000000" fill-opacity="1"><g transform="translate(15.594935, 238.137838)"><g><path d="M 9.75 15.125 C 7.957031 12.476562 6.628906 9.679688 5.765625 6.734375 C 4.898438 3.796875 4.585938 1.253906 4.828125 -0.890625 L 9.640625 -1.25 C 9.484375 0.84375 9.757812 3.15625 10.46875 5.6875 C 11.1875 8.21875 12.300781 10.601562 13.8125 12.84375 C 15.820312 15.832031 17.773438 17.726562 19.671875 18.53125 C 21.566406 19.332031 23.363281 19.164062 25.0625 18.03125 C 26.269531 17.207031 26.945312 16.171875 27.09375 14.921875 C 27.25 13.671875 27.097656 12.320312 26.640625 10.875 C 26.191406 9.4375 25.460938 7.617188 24.453125 5.421875 C 23.160156 2.421875 22.226562 -0.0546875 21.65625 -2.015625 C 21.082031 -3.984375 21.035156 -5.957031 21.515625 -7.9375 C 21.992188 -9.914062 23.332031 -11.644531 25.53125 -13.125 C 28.269531 -14.96875 31.273438 -15.332031 34.546875 -14.21875 C 37.828125 -13.113281 40.832031 -10.53125 43.5625 -6.46875 C 44.988281 -4.351562 46.132812 -2.050781 47 0.4375 C 47.863281 2.925781 48.300781 5.160156 48.3125 7.140625 L 43.46875 7.609375 C 43.519531 3.648438 42.285156 -0.191406 39.765625 -3.921875 C 37.867188 -6.742188 35.941406 -8.53125 33.984375 -9.28125 C 32.023438 -10.039062 30.238281 -9.878906 28.625 -8.796875 C 27.382812 -7.953125 26.660156 -6.875 26.453125 -5.5625 C 26.253906 -4.257812 26.378906 -2.882812 26.828125 -1.4375 C 27.285156 0 28.039062 1.898438 29.09375 4.265625 C 30.351562 7.222656 31.265625 9.65625 31.828125 11.5625 C 32.398438 13.46875 32.460938 15.382812 32.015625 17.3125 C 31.566406 19.25 30.285156 20.929688 28.171875 22.359375 C 25.316406 24.285156 22.242188 24.617188 18.953125 23.359375 C 15.660156 22.109375 12.59375 19.363281 9.75 15.125 Z M 9.75 15.125 "/></g></g></g><g fill="#000000" fill-opacity="1"><g transform="translate(40.128802, 274.486215)"><g><path d="M 58.3125 -1.59375 L 32.4375 28.1875 L 28.59375 24.84375 L 33.3125 19.40625 C 30.6875 20.300781 28.007812 20.441406 25.28125 19.828125 C 22.5625 19.222656 20.015625 17.890625 17.640625 15.828125 C 13.742188 12.441406 11.613281 8.6875 11.25 4.5625 C 10.894531 0.445312 12.539062 -3.703125 16.1875 -7.890625 L 31.1875 -25.15625 L 35.21875 -21.671875 L 20.5625 -4.796875 C 17.832031 -1.660156 16.535156 1.390625 16.671875 4.359375 C 16.816406 7.328125 18.320312 10.054688 21.1875 12.546875 C 24.320312 15.265625 27.625 16.457031 31.09375 16.125 C 34.5625 15.800781 37.769531 13.941406 40.71875 10.546875 L 54.296875 -5.078125 Z M 58.3125 -1.59375 "/></g></g></g><g fill="#000000" fill-opacity="1"><g transform="translate(86.413389, 315.537427)"><g><path d="M 66.328125 -19.6875 C 71.015625 -18.113281 74.242188 -15.523438 76.015625 -11.921875 C 77.796875 -8.316406 77.800781 -3.882812 76.03125 1.375 L 68.765625 23.0625 L 63.71875 21.359375 L 70.828125 0.171875 C 72.128906 -3.710938 72.179688 -6.988281 70.984375 -9.65625 C 69.796875 -12.320312 67.492188 -14.226562 64.078125 -15.375 C 60.191406 -16.675781 56.734375 -16.503906 53.703125 -14.859375 C 50.671875 -13.210938 48.445312 -10.28125 47.03125 -6.0625 L 40.453125 13.5625 L 35.40625 11.875 L 42.515625 -9.3125 C 43.816406 -13.195312 43.875 -16.472656 42.6875 -19.140625 C 41.5 -21.816406 39.175781 -23.734375 35.71875 -24.890625 C 31.875 -26.179688 28.425781 -26.003906 25.375 -24.359375 C 22.320312 -22.722656 20.085938 -19.796875 18.671875 -15.578125 L 12.09375 4.046875 L 7.03125 2.359375 L 19.578125 -35.046875 L 24.421875 -33.421875 L 22.125 -26.59375 C 24.207031 -28.414062 26.644531 -29.546875 29.4375 -29.984375 C 32.226562 -30.429688 35.160156 -30.140625 38.234375 -29.109375 C 41.367188 -28.054688 43.859375 -26.476562 45.703125 -24.375 C 47.554688 -22.28125 48.617188 -19.738281 48.890625 -16.75 C 51.097656 -18.757812 53.722656 -20.03125 56.765625 -20.5625 C 59.816406 -21.09375 63.003906 -20.800781 66.328125 -19.6875 Z M 66.328125 -19.6875 "/></g></g></g><g fill="#000000" fill-opacity="1"><g transform="translate(175.791465, 342.010616)"><g><path d="M 49.765625 -48.0625 C 54.648438 -48.820312 58.710938 -48.015625 61.953125 -45.640625 C 65.191406 -43.273438 67.242188 -39.347656 68.109375 -33.859375 L 71.65625 -11.265625 L 66.390625 -10.4375 L 62.921875 -32.515625 C 62.285156 -36.566406 60.820312 -39.5 58.53125 -41.3125 C 56.25 -43.132812 53.332031 -43.765625 49.78125 -43.203125 C 45.71875 -42.566406 42.722656 -40.816406 40.796875 -37.953125 C 38.867188 -35.097656 38.25 -31.472656 38.9375 -27.078125 L 42.15625 -6.625 L 36.890625 -5.796875 L 33.421875 -27.875 C 32.785156 -31.925781 31.328125 -34.859375 29.046875 -36.671875 C 26.765625 -38.492188 23.820312 -39.125 20.21875 -38.5625 C 16.21875 -37.9375 13.238281 -36.191406 11.28125 -33.328125 C 9.320312 -30.460938 8.6875 -26.832031 9.375 -22.4375 L 12.59375 -1.984375 L 7.328125 -1.15625 L 1.203125 -40.125 L 6.25 -40.921875 L 7.375 -33.8125 C 8.382812 -36.382812 10.019531 -38.507812 12.28125 -40.1875 C 14.550781 -41.863281 17.289062 -42.953125 20.5 -43.453125 C 23.757812 -43.972656 26.695312 -43.726562 29.3125 -42.71875 C 31.925781 -41.707031 34.039062 -39.941406 35.65625 -37.421875 C 36.675781 -40.210938 38.414062 -42.546875 40.875 -44.421875 C 43.34375 -46.304688 46.304688 -47.519531 49.765625 -48.0625 Z M 49.765625 -48.0625 "/></g></g></g><g fill="#000000" fill-opacity="1"><g transform="translate(263.145945, 323.059254)"><g><path d="M -1.75 -45.015625 C 2.707031 -47.617188 6.773438 -48.503906 10.453125 -47.671875 C 14.128906 -46.847656 17.238281 -44.253906 19.78125 -39.890625 L 32.125 -18.78125 L 27.703125 -16.1875 L 24.59375 -21.5 C 24.601562 -19.125 23.894531 -16.851562 22.46875 -14.6875 C 21.039062 -12.519531 18.945312 -10.628906 16.1875 -9.015625 C 12.382812 -6.796875 8.832031 -5.9375 5.53125 -6.4375 C 2.226562 -6.9375 -0.289062 -8.675781 -2.03125 -11.65625 C -3.726562 -14.550781 -4.046875 -17.492188 -2.984375 -20.484375 C -1.929688 -23.484375 0.878906 -26.320312 5.453125 -29 L 16.265625 -35.3125 L 15.0625 -37.375 C 13.34375 -40.320312 11.21875 -42.078125 8.6875 -42.640625 C 6.15625 -43.210938 3.316406 -42.582031 0.171875 -40.75 C -1.984375 -39.488281 -3.847656 -37.921875 -5.421875 -36.046875 C -7.003906 -34.171875 -8.140625 -32.195312 -8.828125 -30.125 L -12.90625 -32.328125 C -12.03125 -34.804688 -10.617188 -37.148438 -8.671875 -39.359375 C -6.722656 -41.566406 -4.414062 -43.453125 -1.75 -45.015625 Z M 14.765625 -13.078125 C 17.347656 -14.585938 19.222656 -16.472656 20.390625 -18.734375 C 21.554688 -21.003906 21.9375 -23.523438 21.53125 -26.296875 L 18.28125 -31.875 L 7.59375 -25.640625 C 1.769531 -22.234375 0.046875 -18.503906 2.421875 -14.453125 C 3.578125 -12.460938 5.242188 -11.335938 7.421875 -11.078125 C 9.597656 -10.816406 12.046875 -11.484375 14.765625 -13.078125 Z M 14.765625 -13.078125 "/></g></g></g><g fill="#000000" fill-opacity="1"><g transform="translate(305.701745, 296.496958)"><g><path d="M -12.546875 -31.703125 C -13.441406 -34.492188 -13.445312 -37.226562 -12.5625 -39.90625 C -11.6875 -42.582031 -9.914062 -45.164062 -7.25 -47.65625 L -3.71875 -43.890625 L -4.703125 -43.09375 C -7.734375 -40.25 -9.234375 -37.09375 -9.203125 -33.625 C -9.171875 -30.15625 -7.582031 -26.738281 -4.4375 -23.375 L 9.296875 -8.71875 L 5.421875 -5.078125 L -21.546875 -33.875 L -17.828125 -37.359375 Z M -12.546875 -31.703125 "/></g></g></g><g fill="#000000" fill-opacity="1"><g transform="translate(331.805672, 271.969254)"><g><path d="M -9.375 -55.8125 L 15.734375 -14.453125 C 17.878906 -11.035156 18.988281 -8.023438 19.0625 -5.421875 C 19.144531 -2.816406 18.347656 -0.296875 16.671875 2.140625 C 15.585938 3.691406 14.328125 4.976562 12.890625 6 C 11.460938 7.019531 9.914062 7.679688 8.25 7.984375 L 6.390625 3.6875 C 9.171875 3.175781 11.359375 1.769531 12.953125 -0.53125 C 13.972656 -2.019531 14.429688 -3.570312 14.328125 -5.1875 C 14.234375 -6.800781 13.507812 -8.742188 12.15625 -11.015625 L 10 -14.609375 L -32.40625 -22.5 L -29.25 -27.0625 L 6.765625 -20.21875 L -12.359375 -51.5 Z M -9.375 -55.8125 "/></g></g></g></svg>''';
  String faceId = '';

  bool showAvg = false;

  String info = '';
  int number = -1;
  var date =
  DateFormat('MM/dd/yyyy').format(DateTime.now().subtract(const Duration(days: 7)));
  var startDate = DateFormat('MM/dd/yyyy')
      .format(DateTime.now().subtract(const Duration(days: 30)));
  var endDate = DateFormat('MM/dd/yyyy').format(DateTime.now());

  int dropdownValue = 7;

  final List<int> days = [7, 30];

  final faceDbService = FaceDatabaseService();
  final dbService = DatabaseService();

  final startDateController = TextEditingController();
  final endDateController = TextEditingController();

  DateTimeRange? _selectedDates;

  int num = -1;
  String bigEmotionSvg = '';

  Future _showSelectDatePicker() async {
    final result = await showDateRangePicker(
      initialEntryMode: DatePickerEntryMode.input,
      context: context,
      initialDateRange: _selectedDates,
      firstDate: DateTime(2000),
      lastDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
    );

    if (result != null) {
      setState(() {
        _selectedDates = result;
      });
    }
  }

  String _formatDateToString(DateTime? date) {
    if (date == null) return '-';
    String returnMonth;
    String returnDay;

    if (date.month < 10) {
      returnMonth = '0${date.month}';
    } else {
      returnMonth = '${date.month}';
    }

    if (date.day < 10) {
      returnDay = '0${date.day}';
    } else {
      returnDay = '${date.day}';
    }

    return '${returnMonth}/${returnDay}/${date.year}';
  }

  Widget _bigSvg(int num, String svg) {
    if (num == -1) {
      return SvgPicture.string(
        emotionSummarySvg,
        height: 200,
        width: 200,
      );
    } else {
      return SvgPicture.string(
        svg,
        height: 200,
        width: 200,
      );
    }
  }

  Widget _totalTimes(int num) {
    if (num == -1) {
      return const SizedBox(
        width: 60,
        height: 34,
      );
    }
    return SizedBox(
        child: Wrap(
          spacing: 1.0,
          direction: Axis.horizontal,
          children: [
            Text(
              'You\'ve felt this emotion ',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            FutureBuilder<int>(
              future: dbService.countEmotionUse(info),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData) {
                  if (snapshot.data == 0) {
                    return Text(
                        '0 times.\n',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayLarge
                    );
                  } else {
                    if (snapshot.data == 1) {
                      return Text(
                          '${snapshot.data} time.\n',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displayLarge
                      );
                    } else {
                      return Text(
                          '${snapshot.data} times.\n',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displayLarge
                      );
                    }
                  }
                }
                return Text(
                    '0 times\n',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayLarge
                );
              },
            ),
          ],
        ));
  }

  Widget _usedSinceDate(int num) {
    if (num == -1) {
      return Text('Choose an emotion to see your emotion summary.',
        style: Theme.of(context).textTheme.headlineMedium,
        textAlign: TextAlign.center,
      );
    }
    return SizedBox(
      child: Wrap(
          spacing: 5.0,
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
          children: [
            Text(
                'In the last ',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge
            ),
            DropdownMenu(
              width: 100,
              initialSelection: days.first,
              textStyle: Theme.of(context).textTheme.displayLarge,
              onSelected: (int? value) {
                setState(() {
                  dropdownValue = value!;
                });
              },
              dropdownMenuEntries:
              days.map<DropdownMenuEntry<int>>((int value) {
                return DropdownMenuEntry(
                    value: value, label: value.toString());
              }).toList(),
            ),
            Text('days', style: Theme.of(context).textTheme.displayLarge),
            Text('you', style: Theme.of(context).textTheme.displayLarge),
            Text('have', style: Theme.of(context).textTheme.displayLarge),
            Text('felt', style: Theme.of(context).textTheme.displayLarge),
            Text('this', style: Theme.of(context).textTheme.displayLarge),
            Text('emotion', style: Theme.of(context).textTheme.displayLarge),
            FutureBuilder<int>(
              future: dbService.timesUsedSinceDate(info, DateFormat('MM/dd/yyyy').format(DateTime.now().subtract(Duration(days: dropdownValue)))),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData) {
                  if (snapshot.data == 0) {
                    print(dropdownValue);
                    return Text(
                        '0 times.\n',
                        style: Theme.of(context).textTheme.displayLarge
                    );
                  } else {
                    if (snapshot.data == 1) {
                      return Text(
                          ' ${snapshot.data} time.\n',
                          style: Theme.of(context).textTheme.displayLarge
                      );
                    } else {
                      return Text(
                          ' ${snapshot.data} times.\n',
                          style: Theme.of(context).textTheme.displayLarge
                      );
                    }
                  }
                }
                return Center(
                  child: Text(
                      ' 0 times.\n',
                      style: Theme.of(context).textTheme.displayLarge
                  ),
                );
              },
            ),
          ]),
    );
  }

  Widget _dateRangeButton(int num) {
    if (num == -1) {
      return const SizedBox(
        width: 60,
        height: 34,
      );
    }
    return Center(
      child: ElevatedButton(
        onPressed: _showSelectDatePicker,
        child: Text('choose date range', style: Theme.of(context).textTheme.displayLarge),
      ),
    );
  }

  Widget _usedBetweenDates(int num) {
    if (num == -1) {
      return const SizedBox(
        width: 60,
        height: 34,
      );
    }
    return SizedBox(
        child: Wrap(
          spacing: 5.0,
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
          children: [
            Text('Between', style: Theme.of(context).textTheme.displayLarge),
            Text(_formatDateToString(_selectedDates?.start), style: Theme.of(context).textTheme.displayLarge),
            Text('and', style: Theme.of(context).textTheme.displayLarge),
            Text(_formatDateToString(_selectedDates?.end), style: Theme.of(context).textTheme.displayLarge),
            Text('you', style: Theme.of(context).textTheme.displayLarge),
            Text('have', style: Theme.of(context).textTheme.displayLarge),
            Text('felt', style: Theme.of(context).textTheme.displayLarge),
            Text('this', style: Theme.of(context).textTheme.displayLarge),
            Text('emotion', style: Theme.of(context).textTheme.displayLarge),
            FutureBuilder<int>(
              future:
              dbService.timesUsedWithinDates(info, _formatDateToString(_selectedDates?.start), _formatDateToString(_selectedDates?.end)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData) {
                  if (snapshot.data == 0) {
                    return Text(
                        ' 0 times.\n',
                        style: Theme.of(context).textTheme.displayLarge
                    );
                  } else {
                    if (snapshot.data == 1) {
                      return Text(
                          ' ${snapshot.data} time.\n',
                          style: Theme.of(context).textTheme.displayLarge
                      );
                    } else {
                      return Text(
                          ' ${snapshot.data} times.\n',
                          style: Theme.of(context).textTheme.displayLarge
                      );
                    }
                  }
                }
                return Center(
                  child: Text(
                      ' 0 times.\n',
                      style: Theme.of(context).textTheme.displayLarge
                  ),
                );
              },
            )
          ],
        ));
  }

  // if there are no emotions: show emotion summary picture and say
  // "start logging your emotions to see your emotion summary"

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                _bigSvg(num, bigEmotionSvg),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  height: 50,
                  child: FutureBuilder<List<StoreFaces>>(
                    future: faceDbService.getFaces(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasData) {
                        if (snapshot.data!.isEmpty) {
                          num = -1;
                          return const SizedBox(
                            width: 60,
                            height: 34,
                          );
                        }
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) => SizedBox(
                            width: 50,
                            height: 50,
                            child: IconButton(
                              icon: SvgPicture.string(snapshot.data![index].svg),
                              onPressed: () {
                                setState(() {
                                  num = index;
                                  bigEmotionSvg = snapshot.data![index].svg;
                                  info = snapshot.data![index].emotion;
                                  faceId = snapshot.data![index].id;
                                });
                              },
                            ),
                          ),
                        );
                      }
                      return const SizedBox(
                        width: 60,
                        height: 34,
                      );
                    },
                  ),
                ),
                _totalTimes(num),
                _usedSinceDate(num),
                _dateRangeButton(num),
                _usedBetweenDates(num)
              ],
            ),
          )),
    );
  }
}
