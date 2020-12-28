sehir = "Atina";
tarih = "10/03/2014";
saat = "14:30";
localLongitude = 23.66;
localLatitude = 37.98;
timeZone = 2; %-12 - +14

athens = Location(sehir, tarih, saat, timeZone, localLongitude, localLatitude);

ast = AST(athens);
disp("Solar Energy Engineering Processes and Systems Second Edition Kitab�");
disp("Sayfa 53 �rnek 2.3'te ki verilerden yararlanarak a�a��daki AST sonu�lar elde edildi.");

disp("---------Veriler---------");
fprintf("Sehir Adi: %s \n", sehir);
fprintf("Tarih degeri: %s \n", tarih);
fprintf("Saat degeri: %s \n", saat);
fprintf("Time Zone: %f \n",timeZone)
fprintf("Standard Longitude degeri: %f \n", ast.StandardLongitude);
fprintf("Local Longitude degeri: %f \n", localLongitude);
fprintf("Local Latitude degeri: %f \n", localLatitude);

disp("---------Sonu�lar---------");
fprintf("Equation Of Time degeri ~-11 olmal�. Hesaplanan deger = %f \n", ast.EquationOfTime);
fprintf("Longitude Correction degeri ~-25 olmal�. Hesaplanan deger = %f \n", ast.LongitudeCorrection);
fprintf("Apparent Solar Time degeri 13:54 olmal�. Hesaplanan deger zaman olarak = %s \n", ast.AstTime);
fprintf("Apparent Solar Time Hesaplanan ondaklikli deger  = %f \n", ast.AstFloat);

disp(" ");

disp("-----------Solar Altitude and Azimuth Hesaplamalar�-----------");
solar = Solar(ast, athens.LocalLatitude);
fprintf("Hesaplanan Hour Angle Degeri = %f \n", solar.HourAngle);
fprintf("Hesaplanan Declination Degeri = %f \n", solar.Declination);
fprintf("Hesaplanan Altitude Degeri = %f \n", solar.Altitude);
fprintf("Hesaplanan Azimuth Degeri = %f \n", solar.Azimuth);
