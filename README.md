# JAWABAN

1. 3 Tahun
2. Paling sering menggunakan Geolocator untuk fitur peta, sqflite untuk data persistent, getx dan getit untuk state management. library lain sesuai kebutuhan aja.
3. Biasanya memisahkan sesuai fungsi controller ui model repository, memperkecil beberapa widget biar mudah dibaca.
4. Terakhir saat membuat face recognition, gambar dari camera tipe YUV, proses convert ke raw biar bisa diproses firebase face detection slow, jadi harus dinative.
kalau memang tidak ada library nya biasa buat package sendiri. walaupun sampai saat ini kebnyakan semua plugin sudah tersedia.
5. Performa flutter biasanya masalah build, perkecil scope build, gunakan const pada widget yang tidak berubah2.
selain itu untuk hal-hal yang bisa membuat flicker di UI, sebaiknya dipindahkan ke Isolate.
untuk keamanan, flutter belum bisa dicompile, jadi hanya sampai obfuscated saja. masalah di obfuscated, String tidak di-obfuscate, jadi string string rahasia seperti token apps harus berada di memory, atau setidaknya tidak lagi dalam bentuk string, agar ikut diobfuscate oleh flutter.


Akun pub.dev saya, ada beberapa package kecil yang "terpaksa" dibuat:
https://pub.dev/publishers/fuadarradhi.com/packages