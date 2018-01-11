chcp 65001
@echo off

echo Инициализация git
git init
git config merdge.ff true
git config --local core.quotepath false


echo Создаем каталог Build
::Создаем каталог Build
mkdir Build

echo # Каталог Build >> Build/Readme.md
echo.  >> Build/Readme.md
echo Предназначен для промежуточных сборок: >> Build/Readme.md
echo.  >> Build/Readme.md
echo * Обработки для проверки merdge >> Build/Readme.md
echo.  >> Build/Readme.md
echo * Тестовых баз >> Build/Readme.md

echo Создаем каталог doc
::Создаем каталог doc
mkdir doc

echo # Каталог docs >> doc/Readme.md
echo. >> doc/Readme.md
echo Предназначен для хранения файлов документации в формате Markdown  >> doc/Readme.md
echo. >> doc/Readme.md
echo Содержит: >> doc/Readme.md
echo. >> doc/Readme.md
echo * рекомендаций разработчикам и команде проекта >> doc/Readme.md
echo * описание релизов (RELEASE NOTES) и оперативного плана (ROADMAP) >> doc/Readme.md
echo. >> doc/Readme.md
echo Пользовательские инструкции хранятся в WiKi проекта >> doc/Readme.md

echo Создаем каталог features
mkdir features
echo # Каталог features >> features/Readme.md
echo. >> features//Readme.md
echo Компоненты и функциональность продукта и автоматизированные сценарии проверки структурированные по подсистемам и объектам продукта >> features/Readme.md

echo Создаем каталог features/lib
mkdir features/Lib
echo # Каталог features/lib >> features/Lib/Readme.md
echo. >> features/lib/Readme.md
echo Библиотеки для тестов на Vanessa. Рекомендуется добавить флаг Ignore >> features/lib/Readme.md

echo Создаем каталог spec/fixture
mkdir spec
mkdir spec/fixture
echo # Каталог fixtures >> spec/fixture/Readme.md
echo. >> spec/fixture/Readme.md
echo Предназначен для хранения статичных данных загружаемых в базу данных, для целей демонстрации и для целей автоматизированной сборки >> spec/fixture/Readme.md

echo Создаем каталог src
mkdir src
echo # Каталог src >> src/Readme.md
echo. >> src/Readme.md
echo Предназначен для хранения исходных текстов решения, созданных на платформе 1С:Предприятие, содержит: >> src/Readme.md
echo. >> src/Readme.md
echo * исходные коды обработок, интегрированные с помощью проекта precommit1C (oscript версии) >> src/Readme.md

echo Создаем каталог tools
mkdir tools
echo # Каталог tools >> tools/Readme.md
echo. >> tools/Readme.md
echo Предназначен для хранения любых сторонних утилит, необходимых для настройки проекта или для дополнительной установки >> tools/Readme.md

echo Создаем каталог Vendor
mkdir vendor
echo ### Каталог Vendors >> vendor/Readme.md
echo. >> vendor/Readme.md
echo предназначен для хранения внешних зависимостей - библиотек, конфигураций и т.для >> vendor/Readme.md
echo. >> vendor/Readme.md
echo #### модули по умолчанию >> vendor/Readme.md
echo. >> vendor/Readme.md
echo * vanessa-behavior - для разработки через поведение >> vendor/Readme.md

git add --all
git commit -m "first commit"

Set local

set /p "vb=Add VanessaBehavior? (y/n)"
if /i "%vb%"=="Y" (git submodule add https://github.com/silverbulleters/vanessa-behavior.git vendor/vanessa-behavior
git submodule init vendor/vanessa-behavior
) 

set /p "xu=Add xUnit? (y/n)"
if /i "%xu%"=="Y" (git submodule add https://github.com/xDrivenDevelopment/xUnitFor1C.git vendor/xUnit
git submodule init vendor/xUnit)

if /i "%xu%"=="Y"||"%vb%"=="Y" (git add --all
git commit -m "Set submodules")

echo Настройка игнорирования
echo *.log >> .gitignore
echo /Build >> .gitignore

git add --all
git commit "Set gitignore"

echo Установка прекоммита
precommit1C --install
