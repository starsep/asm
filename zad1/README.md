Dany jest obrazek w postaci matrycy pikseli. Kolor każdego piksela zapisany jest na 24 bitach, po 8 bitów dla każdego koloru (RGB). Napiszemy procedurę w asemblerze dla procesora x86-64, pozwalającą rozjaśniać (czyli zwiększać) lub przyciemniać (czyli zmniejszać) poszczególne składowe.

Argumentem procedury powinny być:

- adres matrycy: zapis zapewne wierszami, trzeba będzie wybrać sobie format odpowiedni do konwersji z formatu graficznego;
- rozmiary matrycy: liczba wierszy i kolumn;
- wybrana składowa, którą chcemy zmienić: np. R=1, G=2, B=3;
- liczba do dodania do składowej: bajtowa liczba całkowita (ze znakiem!).

Należy uwzględnić *nasycenie*: po otrzymaniu przepełnienia składowa powinna przyjąć największą (dla dodatnich) lub najmniejszą (dla ujemnych) możliwą wartość. Wynik działania uzyskujemy jako efekt uboczny na podanej matrycy.

Dodatkowo należy napisać program główny w C, który pobierze (jako pierwszy argument) nazwę pliku graficznego (w formacie PPM, kto nie zna niech spyta [Ciocię Wikipedię](https://en.wikipedia.org/wiki/Netpbm_format)) i zamieni go na matrycę (można funkcją z jakiejś biblioteki), po czym wywoła naszą procedurę. Otrzymaną matrycę należy z powrotem zamienić na plik graficzny (ten sam lub inny).

W katalogu [image](http://students.mimuw.edu.pl/~zbyszek/asm/image) znajduje się kilka prostych plików z danymi.

Rozwiązania (programy i przykładowe testy) należy wysyłać do 30 listopada bieżącego roku pocztą emaliowaną na zbyszek@mimuw.edu.pl jako **pojedynczy załącznik** -- archiwum o nazwie wskazującej na autora (np. *ab123456-zad1.tgz*), spakowane z osobnego katalogu o tej samej nazwie (ale bez tgz). Program ma działać w środowisku zainstalowanym w laboratoriach w trybie 64-bitowym.
