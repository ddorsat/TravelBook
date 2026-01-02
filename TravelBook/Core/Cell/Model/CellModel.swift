//
//  CellDetailsModel.swift
//  TravelBook
//
//  Created by ddorsat on 02.01.2026.
//

import Foundation

struct CellModel: Hashable, Identifiable, Codable {
    let id: UUID?
    let image: String
    let theme: Categories
    let title: String
    let subtitle: String
    let date: Date
    let readingTime: Int
    let description: String
    let images: [String]
    
    var dateString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "d MMM yyyy"
        return formatter.string(from: date)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, image, theme, title, subtitle, date, description, images
        case readingTime = "reading_time"
    }
}

extension CellModel {
    static let mock = CellModel(id: UUID(),
                                image: "test",
                                theme: .abroad,
                                title: "Как выбрать чемодан",
                                subtitle: "Гид по комфортным путешествиям",
                                date: .now,
                                readingTime: 5,
                                description: "Правильный чемодан — это инвестиция в спокойствие во время поездки. Мы разберем ключевые критерии выбора: что лучше — пластик или ткань, сколько должно быть колес для маневренности и как подобрать идеальный размер под требования авиакомпаний, чтобы ваш багаж всегда долетал в целости и сохранности.",
                                images: ["test", "test", "test"])

    static let mockArray: [CellModel] = [
        CellModel(id: UUID(),
                  image: "health",
                  theme: .health,
                  title: "Аптечка туриста",
                  subtitle: "Здоровье важнее всего",
                  date: .now,
                  readingTime: 6,
                  description: """
                  Список лекарств, которые обязательно должны быть в вашем чемодане.
                  Что можно купить на месте, а что лучше везти из дома?
                  Разбираемся с правилами провоза медикаментов через границу.
                  """,
                  images: ["test", "test", "test"]),
        CellModel(id: UUID(),
                  image: "packing",
                  theme: .packing,
                  title: "Как выбрать чемодан",
                  subtitle: "Гид по комфортным путешествиям",
                  date: .now,
                  readingTime: 5,
                  description: """
                  Правильный чемодан — это инвестиция в спокойствие во время поездки.
                  Мы разберем ключевые критерии выбора: что лучше — пластик или ткань,
                  сколько должно быть колес для маневренности и как подобрать идеальный
                  размер под требования авиакомпаний.
                  """,
                  images: ["test", "test", "test"]),
        
        CellModel(id: UUID(),
                  image: "fraud",
                  theme: .fraud,
                  title: "Как не попасться мошенникам",
                  subtitle: "Правила безопасности",
                  date: .now,
                  readingTime: 4,
                  description: """
                  Туристические ловушки подстерегают даже опытных путешественников.
                  Узнайте о самых популярных схемах развода: от 'подаренного' браслета
                  до фальшивых полицейских. Мы расскажем, как распознать угрозу
                  и сохранить свои деньги.
                  """,
                  images: ["test", "test", "test"]),
        
        CellModel(id: UUID(),
                  image: "tickets",
                  theme: .tickets,
                  title: "Охота за дешевыми билетами",
                  subtitle: "Секреты лоукостеров",
                  date: .now,
                  readingTime: 7,
                  description: """
                  Летать дешево — это не магия, а технология. Узнайте, когда лучше всего
                  бронировать билеты, почему стоит использовать режим инкогнито при поиске
                  и как стыковочные рейсы могут сэкономить до 50% бюджета.
                  """,
                  images: ["test", "test", "test"]),
        
        CellModel(id: UUID(),
                  image: "food",
                  theme: .food,
                  title: "Уличная еда: риск или кайф?",
                  subtitle: "Гастрономический гид",
                  date: .now,
                  readingTime: 6,
                  description: """
                  Попробовать местную кухню — обязанность каждого туриста. Но как не
                  провести остаток отпуска в номере с отравлением?
                  Правила выбора стрит-фуда и какие блюда лучше обходить стороной.
                  """,
                  images: ["test", "test", "test"]),
        
        CellModel(id: UUID(),
                  image: "budget",
                  theme: .budget,
                  title: "Искусство ручной клади",
                  subtitle: "Путешествуем налегке",
                  date: .now,
                  readingTime: 8,
                  description: """
                  Забудьте о перевесе багажа и доплатах. Метод 'капсульного гардероба'
                  позволит взять вещей на две недели в один рюкзак. Учимся сворачивать
                  одежду и эффективно использовать пространство.
                  """,
                  images: ["test", "test", "test"]),
        
        CellModel(id: UUID(),
                  image: "leisure",
                  theme: .leisure,
                  title: "Идеальные фото в Instagram",
                  subtitle: "Снимаем как профи",
                  date: .now,
                  readingTime: 5,
                  description: """
                  Вам не нужна дорогая камера, чтобы делать потрясающие снимки.
                  Простые правила композиции, работа со светом и 'золотой час'.
                  Как найти необычные ракурсы популярных достопримечательностей.
                  """,
                  images: ["test", "test", "test"]),
        
        CellModel(id: UUID(),
                  image: "culture",
                  theme: .culture,
                  title: "Без слов: общение за границей",
                  subtitle: "Языковой барьер",
                  date: .now,
                  readingTime: 4,
                  description: """
                  Что делать, если никто не говорит по-английски? Подборка лучших
                  оффлайн-переводчиков, язык жестов и список из 10 фраз, которые
                  стоит выучить на языке страны пребывания.
                  """,
                  images: ["test", "test", "test"])]
    
    static let popularMockArray: [CellModel] = [
        CellModel(id: UUID(),
                  image: "fraud",
                  theme: .fraud,
                  title: "Как не попасться мошенникам",
                  subtitle: "Правила безопасности",
                  date: .now,
                  readingTime: 4,
                  description: """
                  Туристические ловушки подстерегают даже опытных путешественников.
                  Узнайте о самых популярных схемах развода: от 'подаренного' браслета
                  до фальшивых полицейских. Мы расскажем, как распознать угрозу
                  и сохранить свои деньги.
                  """,
                  images: ["test", "test", "test"]),
        CellModel(id: UUID(),
                  image: "health",
                  theme: .health,
                  title: "Аптечка туриста",
                  subtitle: "Здоровье важнее всего",
                  date: .now,
                  readingTime: 6,
                  description: """
                  Список лекарств, которые обязательно должны быть в вашем чемодане.
                  Что можно купить на месте, а что лучше везти из дома?
                  Разбираемся с правилами провоза медикаментов через границу.
                  """,
                  images: ["test", "test", "test"]),
        CellModel(id: UUID(),
                  image: "food",
                  theme: .food,
                  title: "Уличная еда: риск или кайф?",
                  subtitle: "Гастрономический гид",
                  date: .now,
                  readingTime: 6,
                  description: """
                  Попробовать местную кухню — обязанность каждого туриста. Но как не
                  провести остаток отпуска в номере с отравлением?
                  Правила выбора стрит-фуда и какие блюда лучше обходить стороной.
                  """,
                  images: ["test", "test", "test"]),
        CellModel(id: UUID(),
                  image: "leisure",
                  theme: .leisure,
                  title: "Идеальные фото в Instagram",
                  subtitle: "Снимаем как профи",
                  date: .now,
                  readingTime: 5,
                  description: """
                  Вам не нужна дорогая камера, чтобы делать потрясающие снимки.
                  Простые правила композиции, работа со светом и 'золотой час'.
                  Как найти необычные ракурсы популярных достопримечательностей.
                  """,
                  images: ["test", "test", "test"])]
    
    static let foodMockArray: [CellModel] = [
        CellModel(id: UUID(),
                  image: "food",
                  theme: .food,
                  title: "Гастро-тур своими силами",
                  subtitle: "Вкусно и недорого",
                  date: .now,
                  readingTime: 5,
                  description: """
                  Не обязательно покупать дорогие экскурсии, чтобы узнать вкус города.
                  Как составить маршрут по лучшим кафе, пекарням и рынкам самостоятельно.
                  Секретные места, где едят местные, а не туристы.
                  """,
                  images: ["test", "test", "test"]),
        
        CellModel(id: UUID(),
                  image: "food",
                  theme: .food,
                  title: "Кофейная карта мира",
                  subtitle: "Гид кофемана",
                  date: .now,
                  readingTime: 4,
                  description: """
                  Где подают лучший эспрессо, а где стоит заказать флэт уайт?
                  Разбираемся в кофейных традициях Италии, Турции, Вьетнама и Колумбии.
                  Что сказать бариста, чтобы получить именно то, что вы хотите.
                  """,
                  images: ["test", "test", "test"]),
        
        CellModel(id: UUID(),
                  image: "food",
                  theme: .food,
                  title: "Странные деликатесы Азии",
                  subtitle: "Для смелых",
                  date: .now,
                  readingTime: 7,
                  description: """
                  Жареные кузнечики, дуриан и суп из змеи. Стоит ли рисковать желудком
                  ради экзотики? Полный обзор самых необычных блюд, которые мы
                  попробовали, и наши честные оценки вкуса.
                  """,
                  images: ["test", "test", "test"]),
        
        CellModel(id: UUID(),
                  image: "food",
                  theme: .food,
                  title: "Этикет за столом",
                  subtitle: "Культурный код",
                  date: .now,
                  readingTime: 3,
                  description: """
                  Почему в Японии нельзя втыкать палочки в рис, а в Италии — заказывать
                  капучино после обеда? Простые правила, которые помогут не выглядеть
                  невеждой в ресторане другой страны.
                  """,
                  images: ["test", "test", "test"])]
    
    static let leisureMockArray: [CellModel] = [
        CellModel(id: UUID(),
                  image: "leisure",
                  theme: .leisure,
                  title: "Бесплатные музеи Европы",
                  subtitle: "Культура даром",
                  date: .now,
                  readingTime: 6,
                  description: """
                  Искусство должно быть доступным. Список лучших музеев и галерей
                  Лондона, Парижа и Берлина, куда можно попасть абсолютно бесплатно.
                  Дни открытых дверей и лайфхаки для студентов.
                  """,
                  images: ["leisure", "leisure", "leisure"]),
        
        CellModel(id: UUID(),
                  image: "leisure",
                  theme: .leisure,
                  title: "Секретные пляжи",
                  subtitle: "Вдали от толпы",
                  date: .now,
                  readingTime: 5,
                  description: """
                  Устали бороться за лежак под солнцем? Мы нашли для вас уединенные
                  бухты и дикие пляжи, о которых не пишут в путеводителях.
                  Координаты райских мест, где будете только вы и море.
                  """,
                  images: ["test", "test", "test"]),
        
        CellModel(id: UUID(),
                  image: "leisure",
                  theme: .leisure,
                  title: "Ночная жизнь: гид по барам",
                  subtitle: "Веселье без границ",
                  date: .now,
                  readingTime: 4,
                  description: """
                  Как найти лучшие вечеринки в незнакомом городе и безопасно вернуться
                  в отель. Обзор барных улиц, правила дресс-кода и средний чек
                  на коктейли в популярных туристических столицах.
                  """,
                  images: ["test", "test", "test"]),
        
        CellModel(id: UUID(),
                  image: "leisure",
                  theme: .leisure,
                  title: "Хайкинг для новичков",
                  subtitle: "Активный отдых",
                  date: .now,
                  readingTime: 8,
                  description: """
                  Горы зовут! Что положить в рюкзак, какую обувь выбрать и как
                  рассчитать свои силы на маршруте. Простые и живописные тропы
                  для тех, кто впервые решил отправиться в поход.
                  """,
                  images: ["test", "test", "test"])]
}
