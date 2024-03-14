Тестовое задание iOS (NTPro)
---
🔨 Требования по реализации
Цена сделки и объем сделки (поля price и amount) приходят в Double, цену надо округлить до сотых, а объем до целых.
На экране должен быть интерфейс для того, чтобы сменить поле сортировки и направление сортировки.
В зависимости от стороны сделки необходимо подкрашивать цену либо в красный - для sell, либо в зеленый для buy.
При скроле списка он не должен тормозить.
Проект должен быть выполнен в git-репозитории, на который необходимо предоставить ссылку.
Делать изменения в классе Server нельзя. Необходимо строить решение, подразумевая, что в любой момент времени может прилететь новая пачка со сделками.

---

Так как нет уточнения по минимальным требованиям ОС, минимальной была выбрана iOS 16.0, с целью упростить задачу работы с Botttom Sheet.

![IMG_1201 — средний размер](https://github.com/varshaver12/mobileiosdevtestwork/assets/143330929/894c8e97-fe76-4720-ac0f-2c1a417f2649)
![IMG_1202 — средний размер](https://github.com/varshaver12/mobileiosdevtestwork/assets/143330929/569cfb09-dcab-4bb6-9c98-1889d8d615e8)
![IMG_1200 — средний размер](https://github.com/varshaver12/mobileiosdevtestwork/assets/143330929/dde8e2c9-b19d-4b4b-9d58-093d88cc6216)


---
Технологии:
- Язык: Swift 5.6.1
- Фреймворк: UIKit
- Версия iOS: от 16
- Архитектура: MVVM
- Зависимости: SnapKit
