﻿///////////////////////////////////////////////////////////////////
//
// Служебный модуль с набором методов работы с распаковщиком
//
// Представляет собой модификацию приложения gitsync от 
// команды oscript-library
//
///////////////////////////////////////////////////////////////////

Перем Лог;

///////////////////////////////////////////////////////////////////

Функция ПолучитьИНастроитьРаспаковщик(Знач ПараметрыЗапуска, Знач ДополнительныеПараметры) Экспорт

	Лог = ДополнительныеПараметры.Лог;
	Распаковщик = ПолучитьРаспаковщик(ДополнительныеПараметры);
	Распаковщик.ДоменПочтыДляGitПоУмолчанию = ПараметрыЗапуска["-email"];

	КоличествоЦикловОжиданияЛицензии = ПараметрыЗапуска["-amount-look-for-license"];
	Если КоличествоЦикловОжиданияЛицензии = Неопределено Тогда
		КоличествоЦикловОжиданияЛицензии = 1;
	КонецЕсли;
	Распаковщик.УстановитьКоличествоЦикловОжиданияЛицензииПоУмолчанию(Число(КоличествоЦикловОжиданияЛицензии));
	
	Возврат Распаковщик;

КонецФункции // ПолучитьИНастроитьРаспаковщик

Функция ПолучитьРаспаковщик(ПараметрыРаспаковщика) Экспорт

	Распаковщик = Новый МенеджерСинхронизации();
	Распаковщик.УстановитьРежимУдаленияВременныхФайлов(ПараметрыРаспаковщика.УдалятьВременныеФайлы);
	Возврат Распаковщик;

КонецФункции // ПолучитьРаспаковщик

Функция ПодготовитьКаталогНовойРабочейКопии(Знач КаталогРабочейКопииГит) Экспорт

	Если КаталогРабочейКопииГит = Неопределено Тогда

		КаталогРабочейКопииГит = ТекущийКаталог();

	Иначе
	
		ФайлРК = Новый Файл(КаталогРабочейКопииГит);
		КаталогРабочейКопииГит = ФайлРК.ПолноеИмя;

	КонецЕсли;

	Возврат КаталогРабочейКопииГит;

КонецФункции // ПодготовитьКаталогНовойРабочейКопии

Процедура НаполнитьКаталогРабочейКопииСлужебнымиДанными(Знач КаталогРабочейКопии, Знач Распаковщик, Знач ПутьКХранилищу) Экспорт

	КаталогИсходников = Новый Файл(КаталогРабочейКопии);
	Если Не КаталогИсходников.Существует() Тогда

		СоздатьКаталог(КаталогИсходников.ПолноеИмя);

	ИначеЕсли Не КаталогИсходников.ЭтоКаталог() Тогда
		
		ВызватьИсключение "Невозможно создать каталог " + КаталогИсходников.ПолноеИмя;

	КонецЕсли;

	СгенерироватьФайлAUTHORS(ПутьКХранилищу, КаталогИсходников.ПолноеИмя, Распаковщик);
	СгенерироватьФайлVERSION(КаталогИсходников.ПолноеИмя, Распаковщик);

КонецПроцедуры // НаполнитьКаталогРабочейКопииСлужебнымиДанными

Процедура ВыполнитьЭкспортИсходников(Знач Распаковщик, 
									Знач ПутьКХранилищу, 
									Знач ЛокальныйКаталогГит, 
									Знач НачальнаяВерсия = 0, 
									Знач КонечнаяВерсия = 0, 
									Знач Формат = Неопределено, 
									Знач КоличествоКоммитовДоPush = 0, 
									Знач URLРепозитория = Неопределено, 
									Знач Лимит = 0,
									Знач ПроверитьАвторовХранилища = Ложь) Экспорт

	ФайлБазыДанныхХранилища = ПолучитьПутьКБазеДанныхХранилища(ПутьКХранилищу);
	Распаковщик.СинхронизироватьХранилищеКонфигурацийСГит(ЛокальныйКаталогГит, 
															ФайлБазыДанныхХранилища, 
															НачальнаяВерсия, 
															КонечнаяВерсия, 
															Формат, 
															КоличествоКоммитовДоPush, 
															URLРепозитория, 
															Лимит,
															ПроверитьАвторовХранилища);

КонецПроцедуры // ВыполнитьЭкспортИсходников

Функция ТребуетсяСинхронизироватьХранилище(Знач ФайлХранилища, Знач ЛокальныйКаталогГит, Знач ПараметрыРаспаковщика) Экспорт

	Распаковщик = ПолучитьРаспаковщик(ПараметрыРаспаковщика);
	Возврат Распаковщик.ТребуетсяСинхронизироватьХранилищеСГит(ФайлХранилища, ЛокальныйКаталогГит);

КонецФункции // ТребуетсяСинхронизироватьХранилище

///////////////////////////////////////////////////////////////////

Функция ПолучитьПутьКБазеДанныхХранилища(Знач ПутьКХранилищу)
	
	ФайлПутиКХранилищу = Новый Файл(ПутьКХранилищу);
	Если ФайлПутиКХранилищу.Существует() и ФайлПутиКХранилищу.ЭтоКаталог() Тогда
		
		ФайлБазыДанныхХранилища = ОбъединитьПути(ФайлПутиКХранилищу.ПолноеИмя, "1cv8ddb.1CD");

	ИначеЕсли ФайлПутиКХранилищу.Существует() Тогда
	
		ФайлБазыДанныхХранилища = ФайлПутиКХранилищу.ПолноеИмя;

	Иначе
	
		ВызватьИсключение "Некорректный путь к хранилищу: " + ФайлПутиКХранилищу.ПолноеИмя;
	
	КонецЕсли;

	Возврат ФайлБазыДанныхХранилища;

КонецФункции // ПолучитьПутьКБазеДанныхХранилища

Процедура СгенерироватьФайлAUTHORS(Знач ПутьХранилища, Знач КаталогИсходников, Знач Распаковщик)

	ОбъектФайлХранилища = Новый Файл(ПолучитьПутьКБазеДанныхХранилища(ПутьХранилища));
	Если Не ОбъектФайлХранилища.Существует() Тогда
		
		ВызватьИсключение "Файл хранилища <" + ОбъектФайлХранилища.ПолноеИмя + "> не существует.";

	КонецЕсли;

	ФайлАвторов = Новый Файл(ОбъединитьПути(КаталогИсходников, "AUTHORS"));
	Если ФайлАвторов.Существует() Тогда
		
		Лог.Информация("Файл " + ФайлАвторов.ПолноеИмя + " уже существует. Пропускаем генерацию файла AUTHORS");
		Возврат;

	КонецЕсли;

	Попытка

		Лог.Отладка("Формирую файл AUTHORS в каталоге " + КаталогИсходников);
		Распаковщик.СформироватьПервичныйФайлПользователейДляGit(ОбъектФайлХранилища.ПолноеИмя, ФайлАвторов.ПолноеИмя);
		Лог.Отладка("Файл сгенерирован");

	Исключение
		
		Лог.Ошибка("Не удалось сформировать файл авторов");
		ВызватьИсключение;

	КонецПопытки;

КонецПроцедуры // СгенерироватьФайлAUTHORS

Процедура СгенерироватьФайлVERSION(Знач КаталогИсходников, Знач Распаковщик)

	ФайлВерсий = Новый Файл(ОбъединитьПути(КаталогИсходников, "VERSION"));
	Если ФайлВерсий.Существует() Тогда
		
		Лог.Информация("Файл " + ФайлВерсий.ПолноеИмя + " уже существует. Пропускаем генерацию файла VERSION");
		Возврат;

	КонецЕсли;

	Распаковщик.ЗаписатьФайлВерсийГит(ФайлВерсий.Путь);

КонецПроцедуры // СгенерироватьФайлVERSION