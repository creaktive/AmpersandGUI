PRAGMA cache_size=10240;
PRAGMA count_changes=OFF;
PRAGMA journal_mode=OFF;
PRAGMA legacy_file_format=OFF;
PRAGMA synchronous=OFF;
PRAGMA temp_store=2;
CREATE TABLE "dic" ("w" CHAR PRIMARY KEY NOT NULL, "n" INTEGER);
CREATE TABLE "tri" ("a" CHAR, "b" CHAR, "c" CHAR, "p" INTEGER,  "n" INTEGER);
