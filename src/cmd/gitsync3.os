﻿///////////////////////////////////////////////////////////////////
//
#Использовать cli
#Использовать tempfiles
#Использовать "../core"
#Использовать "."

Перем Лог;
Перем Плагины;
Перем ВерсияПлатформы;
Перем ВыводДополнительнойИнформации;
Перем ВременныйКаталогРаботы;
Перем ДоменПочты;
///////////////////////////////////////////////////////////////////////////////

Процедура ВыполнитьПриложение()

	Приложение = Новый КонсольноеПриложение(ПараметрыПриложения.ИмяПриложения(),
											"Приложение для синхронизации Хранилища 1С с git");
	Приложение.Версия("version", ПараметрыПриложения.Версия());
	Приложение.Опция("v8version", "8.3", "маска версии платформы (8.3, 8.3.5, 8.3.6.2299 и т.п.)")
					.ВОкружении("GITSYNC_V8VERSION");

	Приложение.Опция("v verbose", Ложь, "вывод отладочной информация в процессе выполнении")
					.Флаговый()
					.ВОкружении("GITSYNC_VERSOBE");

	Приложение.Опция("p plugins", "", "плагины к загрузке и исполнению (дополнительное ограничение)")
					.ТМассивСтрок()
					.ВОкружении("GITSYNC_RUN_PLUGINS");

	Приложение.Опция("t tempdir", "", "путь к каталогу временных файлов")
					.ВОкружении("GITSYNC_TEMP");
	
	Приложение.Опция("domain-email", "localhost", "домен почты для пользователей git")
					.ВОкружении("GITSYNC_EMAIL");

	Приложение.ДобавитьКоманду("usage u", "Выводит примеры использования",
								Новый КомандаUsage);
	Приложение.ДобавитьКоманду("init i", "Инициализация структуры нового хранилища git. Подготовка к синхронизации",
								Новый КомандаInit);
	Приложение.ДобавитьКоманду("sync s", "Выполняет синхронизацию хранилища 1С с git-репозиторием",
								Новый КомандаSync);
	Приложение.ДобавитьКоманду("clone c", "Клонирует существующий репозиторий и создает служебные файлы",
								Новый КомандаClone);
	//Приложение.ДобавитьКоманду("all a", "Запускает синхронизацию по нескольким репозиториям", Новый КомандаAll);
	Приложение.ДобавитьКоманду("set-version sv", "Устанавливает необходимую версию в файл VERSION",
								Новый КомандаSetVersion);
	Приложение.ДобавитьКоманду("plugins p", "Управление плагинами gitsync",
								Новый Командаplugins);

	Приложение.УстановитьДействиеПередВыполнением(ЭтотОбъект);

	Приложение.Запустить(АргументыКоманднойСтроки);

КонецПроцедуры // ВыполнениеКоманды()

Процедура ПередВыполнениемКоманды(Знач Команда) Экспорт

	Команда.ПередВыполнениемКоманды(Команда);

	ВерсияПлатформы = Команда.ЗначениеОпции("v8version");
	ВыводДополнительнойИнформации = Команда.ЗначениеОпции("verbose");
	Плагины = Команда.ЗначениеОпции("plugins");
	ДоменПочты = Команда.ЗначениеОпции("domain-email");
	ВременныйКаталогРаботы = Команда.ЗначениеОпции("tempdir");
	ДоменПочты = Команда.ЗначениеОпции("domain-email");
	
	ПараметрыПриложения.УстановитьРежимОтладкиПриНеобходимости(ВыводДополнительнойИнформации);

	Лог.Отладка("Устанавливаю общие параметры");
	ПараметрыПриложения.УстановитьВерсиюПлатформы(ВерсияПлатформы);
	//ПараметрыПриложения.УстановитьПлагины(Плагины);
	ПараметрыПриложения.УстановитьДоменПочты(ДоменПочты);
	ПараметрыПриложения.УстановитьВременныйКаталог(ВременныйКаталогРаботы);
	
КонецПроцедуры

///////////////////////////////////////////////////////

Лог = ПараметрыПриложения.Лог();

Попытка

	ВыполнитьПриложение();

Исключение

	Лог.КритичнаяОшибка(ОписаниеОшибки());
	ВременныеФайлы.Удалить();

	ЗавершитьРаботу(1);

КонецПопытки;