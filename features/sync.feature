# language: ru

Функционал: Синхронизация хранилища конфигурации 1С и гит (команды sync)
    Как Пользователь
    Я хочу выполнять автоматическую синхронизацию конфигурации из хранилища
    Чтобы автоматизировать свою работы с хранилищем с git

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
    И Я создаю тестовой файл AUTHORS 
    И Я записываю "0" в файл VERSION
    И Я создаю временный каталог и сохраняю его в контекст
    И Я инициализирую bare репозиторий во временном каталоге
    И Я сохраняю значение временного каталога в переменной "URLРепозитория"
    И я инициализирую связь "ПутьКаталогаИсходников" с внешним репозиторием "URLРепозитория"
    И я включаю отладку лога с именем "oscript.app.gitsync"
   
Сценарий: Простая синхронизация хранилища с git-репозиторием
    Допустим Я создаю временный каталог и сохраняю его в контекст
    И Я сохраняю значение временного каталога в переменной "ВременнаяДиректория"
    И Я добавляю параметр "--tempdir" для команды "gitsync" из переменной "ВременнаяДиректория"
    И Я добавляю параметр "-v" для команды "gitsync"
    И Я добавляю параметр "sync" для команды "gitsync"
    И Я добавляю позиционный параметр для команды "gitsync" из переменной "КаталогХранилища1С"
    И Я добавляю позиционный параметр для команды "gitsync" из переменной "ПутьКаталогаИсходников"
    Когда Я выполняю команду "gitsync"
    Тогда Вывод команды "gitsync" содержит "ИНФОРМАЦИЯ - Синхронизация завершена"
    И Вывод команды "gitsync" не содержит "Внешнее исключение"
    И Код возврата команды "gitsync" равен 0

Сценарий: Синхронизация хранилища с git-репозиторием с использованием текущего рабочего каталога
    Допустим Я создаю временный каталог и сохраняю его в контекст
    И Я сохраняю значение временного каталога в переменной "ВременнаяДиректория"
    И Я добавляю параметр "--tempdir" для команды "gitsync" из переменной "ВременнаяДиректория"
    И Я добавляю параметр "-v" для команды "gitsync"
    И Я добавляю параметр "sync" для команды "gitsync"
    И Я добавляю позиционный параметр для команды "gitsync" из переменной "КаталогХранилища1С"
    И Я устанавливаю рабочей каталог из переменной "ПутьКаталогаИсходников"
    Когда Я выполняю команду "gitsync"
    Тогда Вывод команды "gitsync" содержит "ИНФОРМАЦИЯ - Синхронизация завершена"
    И Вывод команды "gitsync" не содержит "Внешнее исключение"
    И Код возврата команды "gitsync" равен 0

Сценарий: Синхронизация хранилища с git-репозиторием с ошибкой авторизации
    Допустим Я создаю временный каталог и сохраняю его в контекст
    И Я сохраняю значение временного каталога в переменной "ВременнаяДиректория"
    И Я добавляю параметр "--tempdir" для команды "gitsync" из переменной "ВременнаяДиректория"
    И Я добавляю параметр "-v" для команды "gitsync"
    И Я добавляю параметр "sync" для команды "gitsync"
    И Я добавляю параметр "-u Администратор" для команды "gitsync"
    И Я добавляю позиционный параметр для команды "gitsync" из переменной "КаталогХранилища1С"
    И Я добавляю позиционный параметр для команды "gitsync" из переменной "ПутьКаталогаИсходников"
    Когда Я выполняю команду "gitsync"
    Тогда Вывод команды "gitsync" содержит "Ошибка аутентификации в хранилище конфигурации!"
    И Вывод команды "gitsync" не содержит "Внешнее исключение"
    И Код возврата команды "gitsync" равен 1

Сценарий: Синхронизация хранилища с git-репозиторием с ошибкой авторизации
    Допустим Я создаю временный каталог и сохраняю его в контекст
    И Я сохраняю значение временного каталога в переменной "ВременнаяДиректория"
    И Я добавляю параметр "--tempdir" для команды "gitsync" из переменной "ВременнаяДиректория"
    И Я добавляю параметр "-v" для команды "gitsync"
    И Я добавляю параметр "sync" для команды "gitsync"
    И Я добавляю параметр "-u Админ" для команды "gitsync"
    И Я добавляю позиционный параметр для команды "gitsync" из переменной "КаталогХранилища1С"
    И Я добавляю позиционный параметр для команды "gitsync" из переменной "ПутьКаталогаИсходников"
    Когда Я выполняю команду "gitsync"
    Тогда Вывод команды "gitsync" содержит "Ошибка аутентификации в хранилище конфигурации!"
    И Вывод команды "gitsync" не содержит "Внешнее исключение"
    И Код возврата команды "gitsync" равен 1

Сценарий: Синхронизация хранилища с git-репозиторием с использованием переменных окружения
    Допустим Я создаю временный каталог и сохраняю его в контекст
    И Я сохраняю значение временного каталога в переменной "ВременнаяДиректория"
    И Я добавляю параметр "--tempdir" для команды "gitsync" из переменной "ВременнаяДиректория"
    И Я добавляю параметр "-v" для команды "gitsync"
    И Я добавляю параметр "sync" для команды "gitsync"
    И Я устанавливаю переменную окружения "GITSYNC_STORAGE_PATH" из переменной "КаталогХранилища1С"
    И Я устанавливаю переменную окружения "GITSYNC_WORKDIR" из переменной "ПутьКаталогаИсходников"
    Когда Я выполняю команду "gitsync"
    Тогда Вывод команды "gitsync" содержит "ИНФОРМАЦИЯ - Синхронизация завершена"
    И Вывод команды "gitsync" не содержит "Внешнее исключение"
    И Код возврата команды "gitsync" равен 0
    И Я очищаю значение переменных окружения 
    |GITSYNC_STORAGE_PATH|
    |GITSYNC_WORKDIR|