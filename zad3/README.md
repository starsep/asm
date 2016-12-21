# Zadanie 3: zamiana koloru na skalę szarości

Dany jest obrazek w postaci matrycy pikseli. Kolor każdego piksela zapisany jest na 24 bitach, po 8 bitów dla każdego koloru (RGB), jak w zadaniu 1. Należy napisać procedurę w asemblerze procesora ARM, dokonującą konwersji obrazu na skalę szarości przez policzenie średniej ważonej.

Ponieważ oko ludzkie niejednakowo reaguje na kolory (najsilniej na zielony), współczynniki dla poszczególnych składowych nie mogą być jednakowe, zwykle przyjmuje się:

- 77 dla koloru czerwonego,
- 151 dla koloru zielonego i
- 28 dla koloru niebieskiego.

Podane współczynniki sumują się do 256, co ułatwi dzielenie.

Argumentami procedury powinny być:

- adres matrycy: zapis zapewne wierszami, trzeba będzie wybrać sobie odpowiedni format podczas konwersji z formatu graficznego;
- rozmiary matrycy: liczba wierszy i kolumn.

Miło byłoby umożliwić zmienianie wartości współczynników z programu głównego.

Dodatkowo należy napisać program główny (w C lub tp.), który pobierze (jako argument) nazwę pliku graficznego (w formacie PPM, przypominam o [Cioci Wikipedii](http://en.wikipedia.org/wiki/Netpbm_format) i zamieni go na odpowiednią matrycę (można funkcją z jakiejś biblioteki, byleby nie zawierała błędów ;-), po czym wywoła naszą procedurę. Otrzymaną matrycę należy z powrotem zamienić na plik graficzny (z rozszerzeniem .pgm!). Całość powinna działać pod emulatorem QEMU dostępnym na stronie.

W katalogu [image](http://students.mimuw.edu.pl/~zbyszek/asm/image) znajduje się kilka prostych plików z danymi.

Rozwiązania (programy i przykładowe testy) należy wysyłać do dnia 17 stycznia (23:59) pocztą na zbyszek@mimuw.edu.pl jako **pojedynczy załącznik** -- archiwum o nazwie wskazującej na autora (np. ab123456-zad2.tgz), spakowane z osobnego katalogu *o tej samej nazwie* (ale bez tgz). Program ma działać w środowisku zainstalowanym w laboratoriach.
