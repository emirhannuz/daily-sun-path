sehir = "Abu Dabi";
tarih = "15/01/2014";
saat = "14:00";
localLongitude = 54.358;
localLatitude = 24.492;
timeZone = 4; %-12 - +14

abuDhabi = Location(sehir, tarih, saat, timeZone, localLongitude, localLatitude);

ast = AST(abuDhabi);
disp("https://www.e-education.psu.edu/eme812/node/583");
disp("Adresindeki Örnek göz önüne alýnarak hazýrlandý.");

disp("---------Veriler---------");
fprintf("Sehir Adi: %s \n", sehir);
fprintf("Tarih degeri: %s \n", tarih);
fprintf("Saat degeri: %s \n", saat);
fprintf("Time Zone: %f \n",timeZone);
fprintf("Standard Longitude degeri: %f \n", ast.StandardLongitude);
fprintf("Local Longitude degeri: %f \n", localLongitude);
fprintf("Local Latitude degeri: %f \n", localLatitude);

disp("---------Sonuçlar---------");
fprintf("Equation Of Time degeri %f\n", ast.EquationOfTime);
fprintf("Longitude Correction degeri %f\n", ast.LongitudeCorrection);
fprintf("Apparent Solar Time degeri 13:28 olmalý. Hesaplanan deger zaman olarak = %s \n", ast.AstTime);
fprintf("Apparent Solar Time ondalýklý degeri 13.47 olmalý. Hesaplanan deger ondaklikli = %f \n", ast.AstFloat);

disp(" ");

disp("-----------Solar Altitude and Azimuth Hesaplamalarý-----------");
solar = Solar(ast, abuDhabi.LocalLatitude);
fprintf("h = 22.04. Hesaplanan Hour Angle Degeri = %f \n", solar.HourAngle);
fprintf("d = -21.27. Hesaplanan Declination Degeri = %f \n", solar.Declination);
fprintf("a = 39.47. Hesaplanan Altitude Degeri = %f \n", solar.Altitude);
fprintf("z = 26.93. Hesaplanan Azimuth Degeri = %f \n", solar.Azimuth);
