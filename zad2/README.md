# Zadanie 2: symulacja rozchodzenia się ciepła

Naszym celem będzie napisanie funkcji symulujących fikcyjny przepływ pewnej wartości pseudofizycznej (o
wartościach z dziedziny liczb rzeczywistych) przez prostokątną siatkę. Dla ułatwienia nazwijmy tę wartość
ciepłem. Nasza symulacja będzie oczywiście bardzo uproszczona, ale przypominająca tzw. metody elementów
skończonych.

Dana jest prostokątna siatka w postaci tablicy dwuwymiarowej (oczywiście program może na swoje potrzeby
trzymać to w innej postaci, ale mówimy o zewnętrznej, ,,logicznej'' reprezentacji). W każdej komórce
przechowujemy bieżącą wartość temperatury w tej okolicy.

Powyżej górnego i dolnego brzegu siatki (,,na granicy'') znajdują się grzejniki -- źródła dopływu ciepła o
ustalonej na czas symulacji temperaturze. Natomiast na zewnątrz lewego i prawego brzegu są miejsca ucieczki
ciepła -- również o ustalonej, ale dużo niższej temperaturze. Nazwijmy je chłodnicami.

Symulacja odbywać się będzie krokowo. W każdym kroku komórka siatki oddaje ciepło tym sąsiadom, którzy mają
niższą temperaturę niż ona. Utrata jest proporcjonalna do różnicy temperatur. Równocześnie komórka pobiera
ciepło od tych sąsiadów, którzy mają wyższą temperaturę. Mówiąc po prostu, zmiana wartości temperatury
komórki jest proporcjonalna do sumy różnic temperatur z jej sąsiadami. Wielkość zmiany określa współczynnik
proporcjonalności, jednakowy dla wszystkich komórek (czyli zakładamy jednakowe przewodnictwo cieplne
wszystkich komórek).

Dla komórek wewnętrznych za sąsiednie uznajemy 2 komórki po lewej i prawej stronie oraz 2 komórki powyżej i
poniżej. Zewnętrzne komórki brzegowe nie zmieniają temperatury (choć dostarczają ciepło lub je ,,kradną'').
Na rysunku poniżej pokazano sąsiadów komórki oznaczonej gwiazdką.

| |g|g|g|g|g|...| |
|---|---|---|---|---|---|---|---|
|c| | | | | |...|c|
|c| | | | | |...|c|
|c| | |S| | |...|c|
|c| |S|*|S| |...|c|
|c| | |S| | |...|c|
|c| | | | | |...|c|
|c| | | | | |...|c|
|c| | | | | |...|c|
|c| | | | | |...|c|
|...|...|...|...|...|...|...|...|
| |g|g|g|g|g|...| | |

Każdy krok to równoczesne policzenie przyrostów dla każdej komórki. Po obliczeniu przyrostów dla wszystkich
komórek są one do nich dodawane i rozpoczynamy kolejny krok.

Część napisana w języku wewnętrznym powinna eksportować procedury wołane z C:


- ```void start (int szer, int wys, float *M, float *G, float *C, float waga)```

  Przygotowuje symulację, np. inicjuje pomocnicze struktury. Argumentami są: rozmiary matrycy, początkowa zawartość matrycy (temperatury), grzejników i chłodnic oraz wspólczynnik proporcjonalności.

- ```void step ()```

  Przeprowadza pojedynczy krok symulacji. Po jej wykonaniu macierz M (przekazana przez parametr procedury
start) zawiera nowy stan.

Procedury w asemblerze powinny w jak największy stopniu wykorzystywać możliwości instrukcji SSE (do SSE3). W
związku z tym dokładna postać wewnętrzna matrycy M nie jest określona (np. mogą to być dwie macierze),
powinno być jednak możliwe jej łatwe zainicjowanie w programie w C przez wczytanie początkowej zawartości z
pliku.

Testowy program główny napisany w C powinien zainicjować matrycę M oraz wektory G i C (przez wczytanie ich
zawartości z pliku). Nazwę pliku, wspólczynnik proporcjonalności i liczbę kroków symulacji podajemy jako
argumenty wywołania programu z linii poleceń.

Po (prawie) każdym wywołaniu procedury `step()` powinno się wyświetlać aktualną sytuację, np. tekstowo, jako
macierz liczb, po czym czekać na naciśnięcie `<Enter>`.

### Postać danych na pliku

```
szerokość wysokość
pierwszy wiersz M
....
ostatni wiersz M
wiersz z wartościami grzejników
wiersz z wartościami chłodnic
```

Mile widziany prosty plik testowy z danymi.


Rozwiązania nie zawierające pliku **Makefile** nie będą sprawdzane.

Rozwiązania (procedury w asemblerze i program w C z przykładowymi testami) należy wysłać do dnia 21 grudnia
(23:59) pocztą na *zbyszek@mimuw.edu.pl* jako **pojedynczy załącznik** -- archiwum o nazwie wskazującej na autora
(np. **ab123456-zad2.tgz**), spakowane z osobnego katalogu o tej samej nazwie (ale bez tgz). Program ma działać w
środowisku zainstalowanym w laboratoriach w trybie 64-bitowym.
