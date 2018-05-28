#Использовать logos

Перем ИндексПодписчиков;  // Соответствие
Перем Лог; // Объект - логирования

#Область Публичный_интерфейс

// Устанавливает новый индекс подписчиков
//
// Параметры:
//   НовыйИндексПодписчиков - Соответствие - Новый индекс для выполнения подписок
//                                            * ключ - имя подписчика
//                                            * значение - объект подписчика реализующий интерфейс подписчика
//
Процедура УстановитьПодписчиков(НовыйИндексПодписчиков) Экспорт
	
	ИндексПодписчиков = НовыйИндексПодписчиков;

КонецПроцедуры

#КонецОбласти

#Область Подписки_на_события

#Область Подписка_на_активизацию_плагинов

// Вызывается при начале установке новых подписчиков
//
// Параметры:
//   МенеджерСинхронизации - Объект.МенеджерСинхронизации - ссылка на класс МенеджерСинхронизации
//
Процедура ПриАктивизации(МенеджерСинхронизации) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(МенеджерСинхронизации);
	
	ВыполнитьПодпискуНаСобытие("ПриАктивизации", ПараметрыВыполнения);
	
КонецПроцедуры

#КонецОбласти

#Область Подписка_на_получение_параметров_выполнения

// Вызывается при передаче параметров в МенеджерСинхронизации 
//
// Параметры:
//   ПараметрыПодписчиков - Объект.ПараметрыПодписчиков - ссылка на класс ПараметрыПодписчиков
// 
// Объект <ПараметрыПодписчиков> реализовывает публичные функции:
// * Функция <Параметр>
// 		Получает и возвращает значение из индекса параметров
//
// 		Параметры:
//   	  * СтрокаИмениПараметра - Строка - имя параметра допустимо указание нескольких имен к параметру через пробел
//                              		  Например, "config --config -c c"
//   	  * ЗначениеПоУмолчанию  - Произвольный - возвращаемое значение в случае отсутствия параметра после получения из индекса
// 		Возвращаемое значение:
//   	  Строка, Число, Булево, Массив, Соответствие, Неопределено - значение параметра
// * Функция <ПолучитьПараметры> 
// 		Возвращает используемый индекс параметров 
//
// 		Возвращаемое значение:
//   	  Соответствие - соответствие ключей и значение параметров
//
// Примеры: 
//   ```
//   
//   ОтправлятьМетки = ПараметрыПодписчиков.Параметр("push --push P ОтправлятьМетки", Ложь);
//
//   ```
Процедура ПриПолученииПараметров(ПараметрыПодписчиков) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(ПараметрыПодписчиков);
	ВыполнитьПодпискуНаСобытие("ПриПолученииПараметров", ПараметрыВыполнения);

КонецПроцедуры

#КонецОбласти

#Область Подписки_на_регистрацию_команды_приложения

// Вызывается при регистрации команды приложения
//
// Параметры:
//   ИмяКоманды - Строка - имя регистрируемой команды 
//   КлассРеализации - Объект.КомандаПриложения - ссылка на класс <КомандаПриложения>
//
Процедура ПриРегистрацииКомандыПриложения(ИмяКоманды, КлассРеализации) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(ИмяКоманды);
	ПараметрыВыполнения.Добавить(КлассРеализации);
	
	ВыполнитьПодпискуНаСобытие("ПриРегистрацииКомандыПриложения", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, ИмяКоманды, КлассРеализации);

КонецПроцедуры

#КонецОбласти

#Область Подписки_на_начало_и_окончания_выполнения

// Вызывается перед началом работы менеджера синхронизации
//
// Параметры:
//   ПутьКХранилищу - Строка - полный путь к хранилищу конфигурации 
//   КаталогРабочейКопии - Строка - полный путь к рабочему каталогу копии
//
Процедура ПередНачаломВыполнения(ПутьКХранилищу, КаталогРабочейКопии) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(ПутьКХранилищу);
	ПараметрыВыполнения.Добавить(КаталогРабочейКопии);

	ВыполнитьПодпискуНаСобытие("ПередНачаломВыполнения", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, ПутьКХранилищу, КаталогРабочейКопии);

КонецПроцедуры

// Вызывается после окончания работы менеджера синхронизации
//
// Параметры:
//   ПутьКХранилищу - Строка - полный путь к хранилищу конфигурации 
//   КаталогРабочейКопии - Строка - полный путь к рабочему каталогу копии
//
Процедура ПослеОкончанияВыполнения(ПутьКХранилищу, КаталогРабочейКопии) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(ПутьКХранилищу);
	ПараметрыВыполнения.Добавить(КаталогРабочейКопии);

	ВыполнитьПодпискуНаСобытие("ПослеОкончанияВыполнения", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, ПутьКХранилищу, КаталогРабочейКопии);

КонецПроцедуры

#КонецОбласти

#Область Подписки_на_получение_таблицы_версий

// Вызывается при получении таблицы версий из хранилища конфигурации
//
// Параметры:
//   ТаблицаВерсий - ТаблицаЗначений - инициализированная таблица с колонками:
//     * Дата                - Дата   - дата версии
//     * НомерВерсии         - Число  - номер версии
// 	   * Комментарий         - Строка - комментарий автора к версии
//     * Автор               - Строка - имя автора версии в хранилище 
// 	   * Тэг                 - Строка - метка версии в хранилище 	
// 	   * ГУИД_Автора         - Строка - уникальный идентификатор автора версии
//     * ПредставлениеАвтора - Строка - представление автора для коммита в git
//   ПутьКХранилищу - Строка - полный путь к хранилищу конфигурации 
//   СтандартнаяОбработка - Булево - признак отказ от обработки по умолчанию
//
Процедура ПриПолученииТаблицыВерсий(ТаблицаВерсий, ПутьКХранилищу, СтандартнаяОбработка) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(ТаблицаВерсий);
	ПараметрыВыполнения.Добавить(ПутьКХранилищу);
	ПараметрыВыполнения.Добавить(СтандартнаяОбработка);

	ВыполнитьПодпискуНаСобытие("ПриПолученииТаблицыВерсий", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, ТаблицаВерсий, ПутьКХранилищу, СтандартнаяОбработка);

КонецПроцедуры

// Вызывается после получении таблицы версий из хранилища конфигурации
//
// Параметры:
//   ТаблицаВерсий - ТаблицаЗначений - заполненная таблица с колонками:
//     * Дата                - Дата   - дата версии
//     * НомерВерсии         - Число  - номер версии
// 	   * Комментарий         - Строка - комментарий автора к версии
//     * Автор               - Строка - имя автора версии в хранилище 
// 	   * Тэг                 - Строка - метка версии в хранилище 	
// 	   * ГУИД_Автора         - Строка - уникальный идентификатор автора версии
//     * ПредставлениеАвтора - Строка - представление автора для коммита в git
//   ПутьКХранилищу - Строка - полный путь к хранилищу конфигурации 
//
Процедура ПослеПолученияТаблицыВерсий(ТаблицаВерсий, ПутьКХранилищу) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(ТаблицаВерсий);
	ПараметрыВыполнения.Добавить(ПутьКХранилищу);

	ВыполнитьПодпискуНаСобытие("ПослеПолученияТаблицыВерсий", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, ТаблицаВерсий, ПутьКХранилищу);

КонецПроцедуры

#КонецОбласти

#Область Подписки_на_получение_таблицы_пользователей

// Вызывается при получении таблицы пользователей из хранилища конфигурации
//
// Параметры:
//   ТаблицаПользователей - ТаблицаЗначений - инициализированная таблица с колонками:
//     * Автор               - Строка - имя автора версии в хранилище 
//     * ПредставлениеАвтора - Строка - представление автора для коммита в git
// 	   * ГУИД_Автора         - Строка - уникальный идентификатор автора версии
//   ПутьКХранилищу - Строка - полный путь к хранилищу конфигурации 
//   СтандартнаяОбработка - Булево - признак отказ от обработки по умолчанию
//
Процедура ПриПолученииТаблицыПользователей(ТаблицаПользователей, ПутьКХранилищу, СтандартнаяОбработка) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(ТаблицаПользователей);
	ПараметрыВыполнения.Добавить(ПутьКХранилищу);
	ПараметрыВыполнения.Добавить(СтандартнаяОбработка);

	ВыполнитьПодпискуНаСобытие("ПриПолученииТаблицыПользователей", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, ТаблицаПользователей, ПутьКХранилищу, СтандартнаяОбработка);


КонецПроцедуры

// Вызывается после получении таблицы пользователей из хранилища конфигурации
//
// Параметры:
//   ТаблицаПользователей - ТаблицаЗначений - заполненная таблица с колонками:
//     * Автор               - Строка - имя автора версии в хранилище 
//     * ПредставлениеАвтора - Строка - представление автора для коммита в git
// 	   * ГУИД_Автора         - Строка - уникальный идентификатор автора версии
//   ПутьКХранилищу - Строка - полный путь к хранилищу конфигурации 
//
Процедура ПослеПолученияТаблицыПользователей(ТаблицаПользователей, ПутьКХранилищу) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(ТаблицаПользователей);
	ПараметрыВыполнения.Добавить(ПутьКХранилищу);

	ВыполнитьПодпискуНаСобытие("ПослеПолученияТаблицыПользователей", ПараметрыВыполнения);


	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, ТаблицаПользователей, ПутьКХранилищу);

КонецПроцедуры

#КонецОбласти

#Область Подписки_на_обработки_строки_версии

// Вызывается перед началом обработки таблица истории хранилища конфигурации
//
// Параметры:
//   ТаблицаИсторииХранилища - ТаблицаЗначений - заполненная таблица с колонками:
//     * Дата                - Дата   - дата версии
//     * НомерВерсии         - Число  - номер версии
// 	   * Комментарий         - Строка - комментарий автора к версии
//     * Автор               - Строка - имя автора версии в хранилище 
// 	   * Тэг                 - Строка - метка версии в хранилище 	
// 	   * ГУИД_Автора         - Строка - уникальный идентификатор автора версии
//     * ПредставлениеАвтора - Строка - представление автора для коммита в git
//   ТекущаяВерсия - Число - текущая/последняя синхронизированная версия из файла <VERSION>
//   СледующаяВерсия - Число - следующая версия для обработки
//   МаксимальнаяВерсияДляРазбора - Число - максимальная версия для обработки
//
Процедура ПередНачаломЦиклаОбработкиВерсий(ТаблицаИсторииХранилища,
											ТекущаяВерсия,
											СледующаяВерсия,
											МаксимальнаяВерсияДляРазбора) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(ТаблицаИсторииХранилища);
	ПараметрыВыполнения.Добавить(ТекущаяВерсия);
	ПараметрыВыполнения.Добавить(СледующаяВерсия);
	ПараметрыВыполнения.Добавить(МаксимальнаяВерсияДляРазбора);

	ВыполнитьПодпискуНаСобытие("ПередНачаломЦиклаОбработкиВерсий", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения,
										ТаблицаИсторииХранилища,
										ТекущаяВерсия,
										СледующаяВерсия,
										МаксимальнаяВерсияДляРазбора);

КонецПроцедуры

// Вызывается перед обработкой версии хранилища
//
// Параметры:
//   СтрокаВерсии - СтрокаТаблицыЗначений - текущая строка из ТаблицаИсторииХранилища
//   ТекущаяВерсия - Число - текущая версия для обработки
//
Процедура ПередОбработкойВерсииХранилища(СтрокаВерсии, ТекущаяВерсия) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(СтрокаВерсии);
	ПараметрыВыполнения.Добавить(ТекущаяВерсия);

	ВыполнитьПодпискуНаСобытие("ПередОбработкойВерсииХранилища", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, СтрокаВерсии, ТекущаяВерсия);

КонецПроцедуры

// Вызывается при обработкой версии хранилища
//
// Параметры:
//   СтрокаВерсии - СтрокаТаблицыЗначений - текущая строка из ТаблицаИсторииХранилища
//   ТекущаяВерсия - Число - текущая версия для обработки
//
Процедура ПриОбработкеВерсииХранилища(СтрокаВерсии, ТекущаяВерсия) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(СтрокаВерсии);
	ПараметрыВыполнения.Добавить(ТекущаяВерсия);

	ВыполнитьПодпискуНаСобытие("ПриОбработкеВерсииХранилища", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, СтрокаВерсии, ТекущаяВерсия);

КонецПроцедуры

// Вызывается после обработкой версии хранилища
//
// Параметры:
//   СтрокаВерсии - СтрокаТаблицыЗначений - текущая строка из ТаблицаИсторииХранилища
//   ТекущаяВерсия - Число - текущая версия для обработки
//
Процедура ПослеОбработкиВерсииХранилища(СтрокаВерсии, ТекущаяВерсия) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(СтрокаВерсии);
	ПараметрыВыполнения.Добавить(ТекущаяВерсия);

	ВыполнитьПодпискуНаСобытие("ПослеОбработкиВерсииХранилища", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, СтрокаВерсии, ТекущаяВерсия);

КонецПроцедуры

#КонецОбласти

#Область Подписки_на_выполнение_коммита

// Вызывается перед фиксацией изменений в рабочей копии
//
// Параметры:
//   КаталогРабочейКопии - Строка - полный путь к рабочему каталогу копии
//   Комментарий - Строка - комментарий изменений при фиксации
//   Автор - Строка - автор изменений при фиксации 
//   Дата - Дата - дата изменений фиксации 
//
Процедура ПередКоммитом(КаталогРабочейКопии, Комментарий, Автор, Дата) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(КаталогРабочейКопии);
	ПараметрыВыполнения.Добавить(Комментарий);
	ПараметрыВыполнения.Добавить(Автор);
	ПараметрыВыполнения.Добавить(Дата);

	ВыполнитьПодпискуНаСобытие("ПередКоммитом", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, КаталогРабочейКопии, Комментарий, Автор, Дата);

КонецПроцедуры

// Вызывается при фиксации изменений в рабочей копии
//
// Параметры:
//   ГитРепозиторий - Объект.ГитРепозиторий - подготовленный объект класса <ГитРепозиторий>
//   Комментарий - Строка - комментарий при фиксации изменений
//   ПроиндексироватьОтслеживаемыеФайлы - Булево - признак добавления не отслеживаемых файлов в фиксацию
//   ИмяФайлаКомментария - Строка - путь к файлу для записи комментария фиксации
//   АвторДляГит - Строка - автор изменений изменений в формате `Иванов_А <ivanov@mail.ru>`
//   ДатаДляГит - Дата - дата изменений 
//   Коммитер - Строка - автор фиксации изменений в формате `Иванов_А <ivanov@mail.ru>`
//   ДатаКоммитера - Дата - дата фиксации изменений
//
Процедура ПриКоммите(ГитРепозиторий,
						Комментарий,
						ПроиндексироватьОтслеживаемыеФайлы,
						ИмяФайлаКомментария,
						АвторДляГит,
						ДатаДляГит,
						Коммитер,
						ДатаКоммитера) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(ГитРепозиторий);
	ПараметрыВыполнения.Добавить(Комментарий);
	ПараметрыВыполнения.Добавить(ПроиндексироватьОтслеживаемыеФайлы);
	ПараметрыВыполнения.Добавить(ИмяФайлаКомментария);
	ПараметрыВыполнения.Добавить(АвторДляГит);
	ПараметрыВыполнения.Добавить(ДатаДляГит);
	ПараметрыВыполнения.Добавить(Коммитер);
	ПараметрыВыполнения.Добавить(ДатаКоммитера);

	ВыполнитьПодпискуНаСобытие("ПриКоммите", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения,
										ГитРепозиторий,
										Комментарий,
										ПроиндексироватьОтслеживаемыеФайлы,
										ИмяФайлаКомментария,
										АвторДляГит,
										ДатаДляГит,
										Коммитер,
										ДатаКоммитера);

КонецПроцедуры

// Вызывается после фиксацией изменений в рабочей копии
//
// Параметры:
//   ГитРепозиторий - Объект.ГитРепозиторий - подготовленный объект класса <ГитРепозиторий>
//   КаталогРабочейКопии - Строка - полный путь к рабочему каталогу копии
//
Процедура ПослеКоммита(ГитРепозиторий, КаталогРабочейКопии) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(ГитРепозиторий);
	ПараметрыВыполнения.Добавить(КаталогРабочейКопии);

	ВыполнитьПодпискуНаСобытие("ПослеКоммита", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, ГитРепозиторий, КаталогРабочейКопии);

КонецПроцедуры

#КонецОбласти

#Область Подписки_на_начало_и_окончания_выгрузки_версии_конфигурации

// Вызывается перед началом выгрузки версии конфигурации в исходники
//
// Параметры:
//   Конфигуратор - Объект.УправлениеКонфигуратором - инициализированный класс <УправлениеКонфигуратором>
//   КаталогРабочейКопии - Строка - полный путь к рабочему каталогу копии
//   ПутьКХранилищу - Строка - полный путь к хранилищу конфигурации
//   НомерВерсии - Число - номер выгружаемой версии
//
Процедура ПередНачаломВыгрузкиВерсииХранилищаКонфигурации(Конфигуратор, КаталогРабочейКопии, ПутьКХранилищу, НомерВерсии) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(Конфигуратор);
	ПараметрыВыполнения.Добавить(КаталогРабочейКопии);
	ПараметрыВыполнения.Добавить(ПутьКХранилищу);
	ПараметрыВыполнения.Добавить(НомерВерсии);

	ВыполнитьПодпискуНаСобытие("ПередНачаломВыгрузкиВерсииХранилищаКонфигурации", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, Конфигуратор, КаталогРабочейКопии, ПутьКХранилищу, НомерВерсии);

КонецПроцедуры

// Вызывается после окончания выгрузки версии конфигурации в исходники
//
// Параметры:
//   Конфигуратор - Объект.УправлениеКонфигуратором - инициализированный класс <УправлениеКонфигуратором>
//   КаталогРабочейКопии - Строка - полный путь к рабочему каталогу копии
//   ПутьКХранилищу - Строка - полный путь к хранилищу конфигурации
//   НомерВерсии - Число - номер выгружаемой версии
//
Процедура ПослеОкончанияВыгрузкиВерсииХранилищаКонфигурации(Конфигуратор, КаталогРабочейКопии, ПутьКХранилищу, НомерВерсии) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(Конфигуратор);
	ПараметрыВыполнения.Добавить(КаталогРабочейКопии);
	ПараметрыВыполнения.Добавить(ПутьКХранилищу);
	ПараметрыВыполнения.Добавить(НомерВерсии);

	ВыполнитьПодпискуНаСобытие("ПослеОкончанияВыгрузкиВерсииХранилищаКонфигурации", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, Конфигуратор, КаталогРабочейКопии, ПутьКХранилищу, НомерВерсии);

КонецПроцедуры

#КонецОбласти

#Область Подписки_на_загрузку_версии_конфигурации_из_хранилища

// Вызывается перед загрузкой версии конфигурации из хранилища конфигурации
//
// Параметры:
//   Конфигуратор - Объект.УправлениеКонфигуратором - инициализированный класс <УправлениеКонфигуратором>
//   КаталогРабочейКопии - Строка - полный путь к рабочему каталогу копии
//   ПутьКХранилищу - Строка - полный путь к хранилищу конфигурации
//   НомерВерсии - Число - номер выгружаемой версии
//
Процедура ПередЗагрузкойВерсииХранилищаКонфигурации(Конфигуратор, КаталогРабочейКопии, ПутьКХранилищу, НомерВерсии) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(Конфигуратор);
	ПараметрыВыполнения.Добавить(КаталогРабочейКопии);
	ПараметрыВыполнения.Добавить(ПутьКХранилищу);
	ПараметрыВыполнения.Добавить(НомерВерсии);

	ВыполнитьПодпискуНаСобытие("ПередЗагрузкойВерсииХранилищаКонфигурации", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, Конфигуратор, КаталогРабочейКопии, ПутьКХранилищу, НомерВерсии);

КонецПроцедуры

// Вызывается при загрузке версии конфигурации из хранилища конфигурации
//
// Параметры:
//   Конфигуратор - Объект.УправлениеКонфигуратором - инициализированный класс <УправлениеКонфигуратором>
//   КаталогРабочейКопии - Строка - полный путь к рабочему каталогу копии
//   ПутьКХранилищу - Строка - полный путь к хранилищу конфигурации
//   НомерВерсии - Число - номер выгружаемой версии
//   СтандартнаяОбработка - Булево - признак отказ от обработки по умолчанию
//
Процедура ПриЗагрузкеВерсииХранилищаВКонфигурацию(Конфигуратор, КаталогРабочейКопии, ПутьКХранилищу, НомерВерсии, СтандартнаяОбработка) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(Конфигуратор);
	ПараметрыВыполнения.Добавить(КаталогРабочейКопии);
	ПараметрыВыполнения.Добавить(ПутьКХранилищу);
	ПараметрыВыполнения.Добавить(НомерВерсии);
	ПараметрыВыполнения.Добавить(СтандартнаяОбработка);

	ВыполнитьПодпискуНаСобытие("ПриЗагрузкеВерсииХранилищаВКонфигурацию", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, Конфигуратор, КаталогРабочейКопии, ПутьКХранилищу, НомерВерсии, СтандартнаяОбработка);

КонецПроцедуры

// Вызывается после загрузки версии конфигурации из хранилища конфигурации
//
// Параметры:
//   Конфигуратор - Объект.УправлениеКонфигуратором - инициализированный класс <УправлениеКонфигуратором>
//   КаталогРабочейКопии - Строка - полный путь к рабочему каталогу копии
//   ПутьКХранилищу - Строка - полный путь к хранилищу конфигурации
//   НомерВерсии - Число - номер выгружаемой версии
//
Процедура ПослеЗагрузкиВерсииХранилищаВКонфигурацию(Конфигуратор, КаталогРабочейКопии, ПутьКХранилищу, НомерВерсии) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(Конфигуратор);
	ПараметрыВыполнения.Добавить(КаталогРабочейКопии);
	ПараметрыВыполнения.Добавить(ПутьКХранилищу);
	ПараметрыВыполнения.Добавить(НомерВерсии);

	ВыполнитьПодпискуНаСобытие("ПослеЗагрузкиВерсииХранилищаВКонфигурацию", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, Конфигуратор, КаталогРабочейКопии, ПутьКХранилищу, НомерВерсии);

КонецПроцедуры

#КонецОбласти

#Область Подписки_на_выгрузку_конфигурации_в_исходники

// Вызывается перед выгрузкой версии конфигурации в исходники
//
// Параметры:
//   Конфигуратор - Объект.УправлениеКонфигуратором - инициализированный класс <УправлениеКонфигуратором>
//   КаталогРабочейКопии - Строка - полный путь к рабочему каталогу копии
//   КаталогВыгрузки - Строка - полный путь к временноиу каталогу выгрузки
//   ПутьКХранилищу - Строка - полный путь к хранилищу конфигурации
//   НомерВерсии - Число - номер выгружаемой версии
//
Процедура ПередВыгрузкойКонфигурациюВИсходники(Конфигуратор, КаталогРабочейКопии, КаталогВыгрузки, ПутьКХранилищу, НомерВерсии) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(Конфигуратор);
	ПараметрыВыполнения.Добавить(КаталогРабочейКопии);
	ПараметрыВыполнения.Добавить(КаталогВыгрузки);
	ПараметрыВыполнения.Добавить(ПутьКХранилищу);
	ПараметрыВыполнения.Добавить(НомерВерсии);

	ВыполнитьПодпискуНаСобытие("ПередВыгрузкойКонфигурациюВИсходники", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, Конфигуратор, КаталогРабочейКопии, КаталогВыгрузки, ПутьКХранилищу, НомерВерсии);

КонецПроцедуры

// Вызывается при выгрузке версии конфигурации в исходники
//
// Параметры:
//   Конфигуратор - Объект.УправлениеКонфигуратором - инициализированный класс <УправлениеКонфигуратором>
//   КаталогВыгрузки - Строка - полный путь к временному каталогу выгрузки
//   СтандартнаяОбработка - Булево - признак отказ от обработки по умолчанию
//
Процедура ПриВыгрузкеКонфигурациюВИсходники(Конфигуратор, КаталогВыгрузки, СтандартнаяОбработка) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(Конфигуратор);
	ПараметрыВыполнения.Добавить(КаталогВыгрузки);
	
	ПараметрыВыполнения.Добавить(СтандартнаяОбработка);

	ВыполнитьПодпискуНаСобытие("ПриВыгрузкеКонфигурациюВИсходники", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, Конфигуратор, КаталогВыгрузки, СтандартнаяОбработка);


КонецПроцедуры

// Вызывается после выгрузки версии конфигурации в исходники
//
// Параметры:
//   Конфигуратор - Объект.УправлениеКонфигуратором - инициализированный класс <УправлениеКонфигуратором>
//   КаталогВыгрузки - Строка - полный путь к временному каталогу выгрузки
//
Процедура ПослеВыгрузкиКонфигурациюВИсходники(Конфигуратор, КаталогВыгрузки) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(Конфигуратор);
	ПараметрыВыполнения.Добавить(КаталогВыгрузки);

	ВыполнитьПодпискуНаСобытие("ПослеВыгрузкиКонфигурациюВИсходники", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, Конфигуратор, КаталогВыгрузки);

КонецПроцедуры

#КонецОбласти

#Область Подписки_на_очистку_каталога_рабочей_версии

// Вызывается перед очисткой каталога рабочей копии
//
// Параметры:
//   Конфигуратор - Объект.УправлениеКонфигуратором - инициализированный класс <УправлениеКонфигуратором>
//   КаталогРабочейКопии - Строка - полный путь к рабочему каталогу копии
//   КаталогВыгрузки - Строка - полный путь к временному каталогу выгрузки
//   ПутьКХранилищу - Строка - полный путь к хранилищу конфигурации
//   НомерВерсии - Число - номер выгружаемой версии
//
Процедура ПередОчисткойКаталогаРабочейКопии(Конфигуратор, КаталогРабочейКопии, КаталогВыгрузки, ПутьКХранилищу, НомерВерсии) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(Конфигуратор);
	ПараметрыВыполнения.Добавить(КаталогРабочейКопии);
	ПараметрыВыполнения.Добавить(КаталогВыгрузки);
	ПараметрыВыполнения.Добавить(ПутьКХранилищу);
	ПараметрыВыполнения.Добавить(НомерВерсии);

	ВыполнитьПодпискуНаСобытие("ПередОчисткойКаталогаРабочейКопии", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, Конфигуратор, КаталогРабочейКопии, КаталогВыгрузки, ПутьКХранилищу, НомерВерсии);

КонецПроцедуры

// Вызывается при очистке каталога рабочей копии
//
// Параметры:
//   КаталогРабочейКопии - Строка - полный путь к рабочему каталогу копии
//   СоответствиеИменФайловДляПропуска - Соответствие - ключи имен файлов для пропуска при очистки каталога
//   СтандартнаяОбработка - Булево - признак отказ от обработки по умолчанию
//
Процедура ПриОчисткеКаталогаРабочейКопии(КаталогРабочейКопии, СоответствиеИменФайловДляПропуска, СтандартнаяОбработка) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(КаталогРабочейКопии);
	ПараметрыВыполнения.Добавить(СоответствиеИменФайловДляПропуска);
	ПараметрыВыполнения.Добавить(СтандартнаяОбработка);

	ВыполнитьПодпискуНаСобытие("ПриОчисткеКаталогаРабочейКопии", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, КаталогРабочейКопии, СоответствиеИменФайловДляПропуска, СтандартнаяОбработка);

КонецПроцедуры

// Вызывается после очистки каталога рабочей копии
//
// Параметры:
//   КаталогРабочейКопии - Строка - полный путь к рабочему каталогу копии
//   СоответствиеИменФайловДляПропуска - Соответствие - ключи имен файлов для пропуска при очистки каталога
//
Процедура ПослеОчисткиКаталогаРабочейКопии(КаталогРабочейКопии, СоответствиеИменФайловДляПропуска) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(КаталогРабочейКопии);
	ПараметрыВыполнения.Добавить(СоответствиеИменФайловДляПропуска);

	ВыполнитьПодпискуНаСобытие("ПослеОчисткиКаталогаРабочейКопии", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, КаталогРабочейКопии, СоответствиеИменФайловДляПропуска);

КонецПроцедуры

#КонецОбласти

#Область Подписки_на_перемещение_в_каталог_рабочей_копии

// Вызывается перед перемещением файлов в каталог рабочей копии
//
// Параметры:
//   Конфигуратор - Объект.УправлениеКонфигуратором - инициализированный класс <УправлениеКонфигуратором>
//   КаталогРабочейКопии - Строка - полный путь к рабочему каталогу копии
//   КаталогВыгрузки - Строка - полный путь к временному каталогу выгрузки
//   ПутьКХранилищу - Строка - полный путь к хранилищу конфигурации
//   НомерВерсии - Число - номер выгружаемой версии
//
Процедура ПередПеремещениемВКаталогРабочейКопии(Конфигуратор, КаталогРабочейКопии, КаталогВыгрузки, ПутьКХранилищу, НомерВерсии) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(Конфигуратор);
	ПараметрыВыполнения.Добавить(КаталогРабочейКопии);
	ПараметрыВыполнения.Добавить(КаталогВыгрузки);
	ПараметрыВыполнения.Добавить(ПутьКХранилищу);
	ПараметрыВыполнения.Добавить(НомерВерсии);

	ВыполнитьПодпискуНаСобытие("ПередПеремещениемВКаталогРабочейКопии", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, Конфигуратор, КаталогРабочейКопии, КаталогВыгрузки, ПутьКХранилищу, НомерВерсии);

КонецПроцедуры

// Вызывается при перемещении файлов в каталог рабочей копии
//
// Параметры:
//   КаталогРабочейКопии - Строка - полный путь к рабочему каталогу копии
//   КаталогВыгрузки - Строка - полный путь к каталогу выгрузки
//   СтандартнаяОбработка - Булево - признак отказ от обработки по умолчанию
//
Процедура ПриПеремещенииВКаталогРабочейКопии(КаталогРабочейКопии, КаталогВыгрузки, СтандартнаяОбработка) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(КаталогРабочейКопии);
	ПараметрыВыполнения.Добавить(КаталогВыгрузки);
	ПараметрыВыполнения.Добавить(СтандартнаяОбработка);

	ВыполнитьПодпискуНаСобытие("ПриПеремещенииВКаталогРабочейКопии", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, КаталогРабочейКопии, КаталогВыгрузки, СтандартнаяОбработка);

КонецПроцедуры

// Вызывается после перемещения файлов в каталог рабочей копии
//
// Параметры:
//   КаталогРабочейКопии - Строка - полный путь к рабочему каталогу копии
//   КаталогВыгрузки - Строка - полный путь к каталогу выгрузки
//
Процедура ПослеПеремещенияВКаталогРабочейКопии(КаталогРабочейКопии, КаталогВыгрузки) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(КаталогРабочейКопии);
	ПараметрыВыполнения.Добавить(КаталогВыгрузки);

	ВыполнитьПодпискуНаСобытие("ПослеПеремещенияВКаталогРабочейКопии", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, КаталогРабочейКопии, КаталогВыгрузки);

КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область Вспомогательные_процедуры_и_функции

Процедура ВыполнитьПодпискуНаСобытие(Знач ИмяПроцедурыВыполнения, ПараметрыПроцедуры)

	Для Каждого ЭлементИндекса Из ИндексПодписчиков Цикл

		Подписчик = ЭлементИндекса.Значение;
	
		Подписчик.ВыполнитьПодписку(ИмяПроцедурыВыполнения, ПараметрыПроцедуры);

	КонецЦикла;

КонецПроцедуры

Процедура ПрисвоитьЗначенияПараметраПроцедуры(НовыеЗначения,
												Перем0 = Неопределено,
												Перем1 = Неопределено,
												Перем2 = Неопределено,
												Перем3 = Неопределено,
												Перем4 = Неопределено,
												Перем5 = Неопределено,
												Перем6 = Неопределено,
												Перем7 = Неопределено,
												Перем8 = Неопределено,
												Перем9 = Неопределено
												)
	Количество = НовыеЗначения.Количество();

	Для Индекс = 0 По Количество - 1 Цикл

		Если Индекс = 0 Тогда
			Перем0 = НовыеЗначения[Индекс];
		ИначеЕсли Индекс = 1 Тогда
			Перем1 = НовыеЗначения[Индекс];
		ИначеЕсли Индекс = 2 Тогда
			Перем2 = НовыеЗначения[Индекс];
		ИначеЕсли Индекс = 3 Тогда
			Перем3 = НовыеЗначения[Индекс];
		ИначеЕсли Индекс = 4 Тогда
			Перем4 = НовыеЗначения[Индекс];
		ИначеЕсли Индекс = 5 Тогда
			Перем5 = НовыеЗначения[Индекс];
		ИначеЕсли Индекс = 6 Тогда
			Перем6 = НовыеЗначения[Индекс];
		ИначеЕсли Индекс = 7 Тогда
			Перем7 = НовыеЗначения[Индекс];
		ИначеЕсли Индекс = 8 Тогда
			Перем8 = НовыеЗначения[Индекс];
		ИначеЕсли Индекс = 9 Тогда
			Перем9 = НовыеЗначения[Индекс];
		КонецЕсли;

	КонецЦикла;

КонецПроцедуры

Процедура ПриСозданииОбъекта(Знач ВходящийИндексПодписчиков = Неопределено)
	
	Если ВходящийИндексПодписчиков = Неопределено Тогда
		ИндексПодписчиков = Новый Соответствие;
	Иначе
		ИндексПодписчиков = ВходящийИндексПодписчиков;
	КонецЕсли;

	Лог = Логирование.ПолучитьЛог("oscript.app.gitsync.plugins.event-subscriptions");

КонецПроцедуры

#КонецОбласти

