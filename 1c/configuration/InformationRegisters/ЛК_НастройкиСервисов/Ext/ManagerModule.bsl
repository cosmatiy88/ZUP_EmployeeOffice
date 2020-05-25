﻿#Область ПрограммныйИнтерфейс

Функция НастройкиСервиса() Экспорт 
	
	СтруктураВозврата = ЛК_РаботаСФункциями.СтруктураВозврата();
	СтруктураРезультата = Новый Структура("АдресСервера, ЛогинПользователя, ПарольПользователя, ИДБазы, УровеньЛогирования");
	
	ВыборкаЗаписей = РегистрыСведений.ЛК_НастройкиСервисов.Выбрать();
	Если ВыборкаЗаписей.Следующий() Тогда
		ЗаполнитьЗначенияСвойств(СтруктураРезультата, ВыборкаЗаписей);
	Иначе 
		ЛК_РаботаСФункциями.ДобавитьОшибку(СтруктураВозврата, "Не найдены настройки сервиса");
	КонецЕсли;	
	
	ЛК_РаботаСФункциями.ДобавитьРезультат(СтруктураВозврата, СтруктураРезультата);
	
	Возврат СтруктураВозврата;
	
КонецФункции	

#КонецОбласти
