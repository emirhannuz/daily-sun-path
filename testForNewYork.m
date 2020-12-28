sehir = "New York";
tarih = "15/01/2014";
saat = "14:00";
localLongitude = -73.935;
localLatitude = 40.730;
timeZone = -5; %-12 - +14

newYork = Location(sehir, tarih, saat, timeZone, localLongitude, localLatitude);

ast = AST(newYork);

fprintf("Grenwich'in batýsýndaki konumlar için ne gibi deðerler vereceðini görmek için yazýlmýs test scripti\n");

disp("---------Veriler---------");
fprintf("Sehir Adi: %s \n", sehir);
fprintf("Tarih degeri: %s \n", tarih);
fprintf("Saat degeri: %s \n", saat);
fprintf("Time Zone: %f \n",timeZone);
fprintf("Standard Longitude degeri: %f \n", ast.StandardLongitude);
fprintf("Local Longitude degeri: %f \n", localLongitude);
fprintf("Local Latitude degeri: %f \n", localLatitude);

disp("---------Sonuçlar---------");
fprintf("Equation Of Time hesaplanan deger = %f \n", ast.EquationOfTime);
fprintf("Longitude Correction hesaplanan deger = %f \n", ast.LongitudeCorrection);
fprintf("Apparent Solar Time hesaplanan deger zaman olarak = %s \n", ast.AstTime);
fprintf("Apparent Solar Time hesaplanan deger ondaklikli = %f \n", ast.AstFloat);

disp(" ");

disp("-----------Solar Altitude and Azimuth Hesaplamalarý-----------");
solar = Solar(ast, newYork.LocalLatitude);
fprintf("Hesaplanan Hour Angle Degeri = %f \n", solar.HourAngle);
fprintf("Hesaplanan Declination Degeri = %f \n", solar.Declination);
fprintf("Hesaplanan Altitude Degeri = %f \n", solar.Altitude);
fprintf("Hesaplanan Azimuth Degeri = %f \n", solar.Azimuth);
