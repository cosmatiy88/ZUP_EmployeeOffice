﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Объект.Логин = "user@mail.ru";
	Объект.Пароль = "111111";
	                      
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыИмяТаблицыФормы

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура СоздатьПользователя(Команда)
	
	СоздатьПользователяНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура СоздатьСотрудниковПоПользователю(Команда)
	
	СоздатьСотрудниковПоПользователюНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьФото(Команда)
	
	ОбновитьФотоНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура СоздатьОрганизации(Команда)
	
	СоздатьОрганизацииНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура СоздатьДолжности(Команда)
	
	СоздатьДолжностиНаСервере();	
	
КонецПроцедуры

&НаКлиенте
Процедура СоздатьПодразделения(Команда)	
	
	СоздатьПодразделенияНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура СоздатьКадровуюИсторию(Команда)
	СоздатьКадровуюИсториюНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьОбмен(Команда)
	ВыполнитьОбменНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура СоздатьРасчетныеЛистки(Команда)
	СоздатьРасчетныеЛисткиНаСервере();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ВыполнитьОбменНаСервере()
	
	ЛК_ОбменДаннымиСервер.ВыполнитьОбмен();
	
КонецПроцедуры

&НаСервере
Процедура СоздатьПользователяНаСервере()
	
	НастройкиСервиса = ЛК_РаботаСФункциямиКлиентСервер.Результат(ЛК_ОбменДаннымиПовтИсп.НастройкиСервиса());
	Токен = ЛК_РаботаСФункциямиКлиентСервер.Результат(ЛК_ОбменДаннымиСервер.Логин(НастройкиСервиса));
	Результат = ЛК_ОбменДаннымиСервер.СоздатьПользователя(НастройкиСервиса, Токен, Объект.Пользователь, Объект.Логин, Объект.Пароль);
	
	Если ЛК_РаботаСФункциямиКлиентСервер.Ошибка(Результат) Тогда
		ЛК_РаботаСФункциямиКлиентСервер.СообщитьОбОшибках(Результат);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура СоздатьСотрудниковПоПользователюНаСервере()
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	Сотрудники.Ссылка КАК Ссылка
	               |ИЗ
	               |	Справочник.Сотрудники КАК Сотрудники
	               |ГДЕ
	               |	Сотрудники.ФизическоеЛицо = &ФизическоеЛицо";
	
	Запрос.УстановитьПараметр("ФизическоеЛицо", Объект.Пользователь);
	
	НастройкиСервиса = ЛК_РаботаСФункциямиКлиентСервер.Результат(ЛК_ОбменДаннымиПовтИсп.НастройкиСервиса());
	Токен = ЛК_РаботаСФункциямиКлиентСервер.Результат(ЛК_ОбменДаннымиСервер.Логин(НастройкиСервиса));
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		Результат = ЛК_ОбменДаннымиСервер.СоздатьСотрудника(НастройкиСервиса, Токен, "", Выборка.Ссылка);
		
		Если ЛК_РаботаСФункциямиКлиентСервер.Ошибка(Результат) Тогда
			ЛК_РаботаСФункциямиКлиентСервер.СообщитьОбОшибках(Результат);
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Функция  ОбновитьФотоНаСервере()
	
	НастройкиСервиса = ЛК_РаботаСФункциямиКлиентСервер.Результат(ЛК_ОбменДаннымиПовтИсп.НастройкиСервиса());
	Токен = ЛК_РаботаСФункциямиКлиентСервер.Результат(ЛК_ОбменДаннымиСервер.Логин(НастройкиСервиса));
			
	Результат = ЛК_ОбменДаннымиСервер.ОбновитьФотоПользователя(НастройкиСервиса, Токен, "", Объект.Пользователь);
	
	Если ЛК_РаботаСФункциямиКлиентСервер.Ошибка(Результат) Тогда
		ЛК_РаботаСФункциямиКлиентСервер.СообщитьОбОшибках(Результат);
	КонецЕсли;

КонецФункции

&НаСервере
Процедура СоздатьОрганизацииНаСервере()
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	Организации.Ссылка КАК Ссылка
	               |ИЗ
	               |	Справочник.Организации КАК Организации";

	
	НастройкиСервиса = ЛК_РаботаСФункциямиКлиентСервер.Результат(ЛК_ОбменДаннымиПовтИсп.НастройкиСервиса());
	Токен = ЛК_РаботаСФункциямиКлиентСервер.Результат(ЛК_ОбменДаннымиСервер.Логин(НастройкиСервиса));
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		Результат = ЛК_ОбменДаннымиСервер.ДобавитьОрганизацию(НастройкиСервиса, Токен, "", Выборка.Ссылка);
		
		Если ЛК_РаботаСФункциямиКлиентСервер.Ошибка(Результат) Тогда
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(Выборка.Ссылка);
			ЛК_РаботаСФункциямиКлиентСервер.СообщитьОбОшибках(Результат);
		КонецЕсли;
	КонецЦикла;

КонецПроцедуры

&НаСервере
Процедура СоздатьПодразделенияНаСервере()
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	ПодразделенияОрганизаций.Ссылка КАК Ссылка
	               |ИЗ
	               |	Справочник.ПодразделенияОрганизаций КАК ПодразделенияОрганизаций";
	
	НастройкиСервиса = ЛК_РаботаСФункциямиКлиентСервер.Результат(ЛК_ОбменДаннымиПовтИсп.НастройкиСервиса());
	Токен = ЛК_РаботаСФункциямиКлиентСервер.Результат(ЛК_ОбменДаннымиСервер.Логин(НастройкиСервиса));
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		Результат = ЛК_ОбменДаннымиСервер.ДобавитьПодразделение(НастройкиСервиса, Токен,"", Выборка.Ссылка);
		
		Если ЛК_РаботаСФункциямиКлиентСервер.Ошибка(Результат) Тогда
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(Выборка.Ссылка);
			ЛК_РаботаСФункциямиКлиентСервер.СообщитьОбОшибках(Результат);
		КонецЕсли;
	КонецЦикла;

КонецПроцедуры

&НаСервере
Процедура СоздатьДолжностиНаСервере()

	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	Должности.Ссылка КАК Ссылка
	               |ИЗ
	               |	Справочник.Должности КАК Должности";
	
	НастройкиСервиса = ЛК_РаботаСФункциямиКлиентСервер.Результат(ЛК_ОбменДаннымиПовтИсп.НастройкиСервиса());
	Токен = ЛК_РаботаСФункциямиКлиентСервер.Результат(ЛК_ОбменДаннымиСервер.Логин(НастройкиСервиса));
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		Результат = ЛК_ОбменДаннымиСервер.ДобавитьДолжность(НастройкиСервиса, Токен, "", Выборка.Ссылка);
		
		Если ЛК_РаботаСФункциямиКлиентСервер.Ошибка(Результат) Тогда
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(Выборка.Ссылка);
			ЛК_РаботаСФункциямиКлиентСервер.СообщитьОбОшибках(Результат);
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура СоздатьКадровуюИсториюНаСервере()
	
	НастройкиСервиса = ЛК_РаботаСФункциямиКлиентСервер.Результат(ЛК_ОбменДаннымиПовтИсп.НастройкиСервиса());
	Токен = ЛК_РаботаСФункциямиКлиентСервер.Результат(ЛК_ОбменДаннымиСервер.Логин(НастройкиСервиса));

	ЗапросКадровойИстории = Новый Запрос;
	ЗапросКадровойИстории.Текст = 	"ВЫБРАТЬ
									|	КадроваяИсторияСотрудниковИнтервальный.ДатаНачала КАК ДатаНачала,
									|	КадроваяИсторияСотрудниковИнтервальный.Должность КАК Должность,
									|	КадроваяИсторияСотрудниковИнтервальный.Подразделение КАК Подразделение,
									|	КадроваяИсторияСотрудниковИнтервальный.Сотрудник КАК Сотрудник
									|ИЗ
									|	РегистрСведений.КадроваяИсторияСотрудниковИнтервальный КАК КадроваяИсторияСотрудниковИнтервальный
									|ГДЕ
									|	КадроваяИсторияСотрудниковИнтервальный.ФизическоеЛицо = &ФизическоеЛицо
									|ИТОГИ ПО
									|	Сотрудник";
	ЗапросКадровойИстории.УстановитьПараметр("ФизическоеЛицо", Объект.Пользователь);
	
	Выборка = ЗапросКадровойИстории.Выполнить().Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	Пока Выборка.Следующий() Цикл
		СтруктураРабочихМест = Новый Структура;
		МассивРабочихМест = Новый Массив;
		
		СотрудникСсылка = Выборка.Сотрудник;
		
		ВыборкаКадровойИстории = Выборка.Выбрать();
		Пока ВыборкаКадровойИстории.Следующий() Цикл
			СтруктураРабочегоМеста = Новый Структура;
			СтруктураРабочегоМеста.Вставить("position_pk",    ВыборкаКадровойИстории.Должность);
			СтруктураРабочегоМеста.Вставить("subdivision_pk", ВыборкаКадровойИстории.Подразделение);
			СтруктураРабочегоМеста.Вставить("date_from",      ВыборкаКадровойИстории.ДатаНачала);
			МассивРабочихМест.Добавить(СтруктураРабочегоМеста);
		КонецЦикла;
		
		Результат = ЛК_ОбменДаннымиСервер.СоздатьОбновитьКадровойИсториюСотрудника("", НастройкиСервиса, Токен, СотрудникСсылка, МассивРабочихМест);
		
		Если ЛК_РаботаСФункциямиКлиентСервер.Ошибка(Результат) Тогда
			ЛК_РаботаСФункциямиКлиентСервер.СообщитьОбОшибках(Результат);
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура СоздатьРасчетныеЛисткиНаСервере()
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ РАЗЛИЧНЫЕ
	               |	НачисленияУдержанияПоСотрудникам.ФизическоеЛицо КАК ФизическоеЛицо,
	               |	НачисленияУдержанияПоСотрудникам.Сотрудник КАК Сотрудник,
	               |	НачисленияУдержанияПоСотрудникам.Организация КАК Организация,
	               |	НачисленияУдержанияПоСотрудникам.ПериодДействия КАК ПериодДействия
	               |ИЗ
	               |	РегистрНакопления.НачисленияУдержанияПоСотрудникам КАК НачисленияУдержанияПоСотрудникам
	               |ГДЕ
	               |	НачисленияУдержанияПоСотрудникам.ФизическоеЛицо = &ФизическоеЛицо
	               |
	               |УПОРЯДОЧИТЬ ПО
	               |	Организация,
	               |	Сотрудник,
	               |	ФизическоеЛицо,
	               |	ПериодДействия";

    Запрос.УстановитьПараметр("ФизическоеЛицо", Объект.Пользователь);
	
		
	НастройкиСервиса = ЛК_РаботаСФункциямиКлиентСервер.Результат(ЛК_ОбменДаннымиПовтИсп.НастройкиСервиса());
	Токен = ЛК_РаботаСФункциямиКлиентСервер.Результат(ЛК_ОбменДаннымиСервер.Логин(НастройкиСервиса));
		
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл 
		Результат = ЛК_ОбменДаннымиСервер.ДобавитьОбновитьРасчетныйЛист(НастройкиСервиса, Токен, "", Выборка.ПериодДействия, Выборка.Сотрудник, Выборка.ФизическоеЛицо); 
		
		Если ЛК_РаботаСФункциямиКлиентСервер.Ошибка(Результат) Тогда
			ЛК_РаботаСФункциямиКлиентСервер.СообщитьОбОшибках(Результат);
		КонецЕсли;
	КонецЦикла;	
КонецПроцедуры

#КонецОбласти
