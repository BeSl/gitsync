# language: ru

Функционал: Инициализация каталога исходников конфигурации (команда init)
    Как Пользователь
    Я хочу создать каталог исходников конфигурации 1С в git-репозитории
    Чтобы выполнять автоматическую выгрузку конфигураций из хранилища

Контекст: Тестовый контекст
    Когда Я очищаю параметры команды "gitsync" в контексте
    И Я устанавливаю рабочей каталог во временный каталог
    И Я создаю новый объект ГитРепозиторий
    И Я устанавливаю путь выполнения команды "gitsync" к текущей библиотеке
    И Я создаю временный каталог и сохраняю его в контекст
    И я скопировал каталог тестового хранилища конфигурации во временный каталог
    И Я сохраняю значение временного каталога в переменной "КаталогХранилища1С"
    И Я создаю временный каталог и сохраняю его в контекст
    И Я сохраняю значение временного каталога в переменной "ПутьКаталогаИсходников"
    И я включаю отладку лога с именем "oscript.app.gitsync"
   
Сценарий: Инициализация каталога исходников в пустом каталоге внутри git-репозитория
    Допустим Я инициализирую пустой репозиторий в каталог из переменной "ПутьКаталогаИсходников" 
    И Я добавляю параметр "init" для команды "gitsync"
    И Я добавляю позиционный параметр для команды "gitsync" из переменной "КаталогХранилища1С"
    И Я создаю каталог src временный в каталоге из переменной "ПутьКаталогаИсходников" и сохраняю его в контекст в переменной "КаталогSRC"
    И Я добавляю позиционный параметр для команды "gitsync" из переменной "КаталогSRC"
    Когда Я выполняю команду "gitsync"
    Тогда Вывод команды "gitsync" содержит "ИНФОРМАЦИЯ - Инициализация завершена"
    И Вывод команды "gitsync" не содержит "Внешнее исключение"
    И Код возврата команды "gitsync" равен 0
    И В каталоге из переменной "КаталогSRC" создается файл или каталог "AUTHORS"
    И В каталоге из переменной "КаталогSRC" создается файл или каталог "VERSION"
    И В каталоге из переменной "КаталогSRC" не создается файл или каталог ".git"

Сценарий: Инициализация каталога исходников в пустом каталоге внутри git-репозитория с использованием текущего рабочего каталога
    Допустим Я инициализирую пустой репозиторий в каталог из переменной "ПутьКаталогаИсходников" 
    И Я создаю каталог src временный в каталоге из переменной "ПутьКаталогаИсходников" и сохраняю его в контекст в переменной "КаталогSRC"
    И Я добавляю параметр "init" для команды "gitsync"
    И Я добавляю позиционный параметр для команды "gitsync" из переменной "КаталогХранилища1С"
    И Я устанавливаю рабочей каталог из переменной "КаталогSRC"
    Когда Я выполняю команду "gitsync"
    Тогда Вывод команды "gitsync" содержит "ИНФОРМАЦИЯ - Инициализация завершена"
    И Вывод команды "gitsync" не содержит "Внешнее исключение"
    И Код возврата команды "gitsync" равен 0
    И В каталоге из переменной "КаталогSRC" создается файл или каталог "AUTHORS"
    И В каталоге из переменной "КаталогSRC" создается файл или каталог "VERSION"
    И В каталоге из переменной "КаталогSRC" не создается файл или каталог ".git"

Сценарий: Инициализация каталога исходников, не находящегося внутри git-репозитория
    Допустим Я добавляю параметр "init" для команды "gitsync"
    Когда Я добавляю позиционный параметр для команды "gitsync" из переменной "КаталогХранилища1С"
    И Я добавляю позиционный параметр для команды "gitsync" из переменной "ПутьКаталогаИсходников"
    И Я выполняю команду "gitsync"
    Тогда Вывод команды "gitsync" содержит "ИНФОРМАЦИЯ - Инициализация завершена"
    И Вывод команды "gitsync" не содержит "Внешнее исключение"
    И Код возврата команды "gitsync" равен 0
    И В каталоге из переменной "ПутьКаталогаИсходников" создается файл или каталог ".git"

Сценарий: Инициализация каталога исходников в пустом каталоге внутри git-репозитория с использованием переменных окружения
    Допустим  Я инициализирую пустой репозиторий в каталог из переменной "ПутьКаталогаИсходников" 
    И Я добавляю параметр "-v" для команды "gitsync"
    И Я добавляю параметр "init" для команды "gitsync"
    И Я создаю каталог src временный в каталоге из переменной "ПутьКаталогаИсходников" и сохраняю его в контекст в переменной "КаталогSRC"
    И Я устанавливаю переменную окружения "GITSYNC_STORAGE_PATH" из переменной "КаталогХранилища1С"
    И Я устанавливаю переменную окружения "GITSYNC_WORKDIR" из переменной "КаталогSRC"
    Когда Я выполняю команду "gitsync"
    Тогда Вывод команды "gitsync" содержит "ИНФОРМАЦИЯ - Инициализация завершена"
    И Вывод команды "gitsync" не содержит "Внешнее исключение"
    И Код возврата команды "gitsync" равен 0
    И В каталоге из переменной "КаталогSRC" создается файл или каталог "AUTHORS"
    И В каталоге из переменной "КаталогSRC" создается файл или каталог "VERSION"
    И В каталоге из переменной "КаталогSRC" не создается файл или каталог ".git"
    И Я очищаю значение переменных окружения 
    |GITSYNC_STORAGE_PATH|
    |GITSYNC_WORKDIR|