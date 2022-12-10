import UIKit

public struct PostModel {
    public let author: String
    public let description: String
    public let image: String
    public let likes: Int
    public let views: Int
    
    public static func createModel() -> [PostModel] {
        
        var model = [PostModel]()
        model.append(PostModel(author: "maybe_elf. Clubhouse сократил сотрудников для оптимизации бизнеса.",
                               description:
                                """
                                Соцсеть Clubhouse решила сократить часть сотрудников в рамках смены стратегии и реструктуризации. Сервис откажется от развития некоторых направлений, в том числе новостей и спорта и международных партнерств.
                                «Несколько должностей были ликвидированы в рамках оптимизации нашей команды, а несколько человек решили найти новые возможности. Мы продолжаем набирать сотрудников на многие должности в сферах инженерии, продукта и дизайна», — заявил представитель Clubhouse в комментарии Bloomberg.
                                По данным агентства, несколько человек действительно ушли по собственной воле после того, как Clubhouse решил отказаться от развития некоторых направлений.
                                Clubhouse запустили в 2020 году. Изначально это была соцсеть с закрытыми аудиочатами, однако со временем туда добавили новые функции, в том числе систему денежных переводов совместно с сервисом Stripe, которая работает внутри приложения. В ноябре 2021 года глава Clubhouse Пол Дэвисон говорил, что число ежедневных эфиров в приложении достигло 700 тысяч.
                                Сразу несколько крупных технологических компаний после появления Clubhouse начали разрабатывать свои аналоги. В Telegram внедрили функции аудиочатов по типу Clubhouse. Twitter хотела выкупить соцсеть, но переговоры остановили. В итоге компания запустила собственные аудиочаты Spaces.
                                """,
                               image: "maybe_elf",
                               likes: 41,
                               views: 364))
        
        model.append(PostModel(author: "denis-19. Капитал Маска уменьшился на $16,9 млрд, акции Tesla упали на 9% после сообщения о планах сократить штат компании на 10%.",
                               description:
                                """
                                По данным Forbes, состояние Илона Маска уменьшилось на $16,2 млрд, а акции Tesla упали на 9,22% после сообщения в СМИТ о планах сократить штат компании на 10% и прекратить найм персонала из-за очень плохого предчувствия относительно американской экономики.
                                
                                В настоящий момент состояние Маска оценивается в $216,8 млрд, а капитализация Tesla упала до 729 млрд. Маск остается самым богатым человеком в мире, на втором месте за ним Джефф Безос, третий Бернар Арно, Билл Гейтс четвертый.
                                
                                По уточнению главного рыночного стратега Miller Tabak Мэтта Малей, в конце недели акции Tesla упали на 33% в годовом выражении из-за заявлений и действий руководства. По его мнению, сейчас, вероятно, инвесторы мечтают, чтобы Маск «заткнулся».
                                
                                Другие эксперты рынка также считают, что акции Tesla демонстрируют хороший рост, только когда руководитель компании молчит. «Tesla — быстрорастущая компания, которая наращивает производство на двух новых заводах, поэтому увольнения и приостановка найма вызывает много вопросов. Судя по сегодняшней реакции, рынок готовится к худшему», — заявил изданию аналитик CFRA Гарретт Нельсон.
                                
                                3 июня СМИ сообщили, что Маск собрали сократить около 10% рабочих мест в Tesla. Об этом написал в рассылке для сотрудников.
                                
                                1 июня Маск разослал сотрудникам Tesla письма с сообщением о запрете удаленной работы. Теперь сотрудники компании должны проводить в офисе не менее 40 часов в неделю, а те, кто не согласен — могут покинуть Tesla.
                                
                                В конце апреля Маск и Tesla пережили более глобальные финансовые катаклизмы после объявления Маска о приобретении Twitter. Тогда акции компании Tesla упали на 12%, а Маск потерял $29 млрд.
                                """,
                               image: "denis-19",
                               likes: 383,
                               views: 1564))
        
        
        model.append(PostModel(author: "daniilshat. Apple запатентовала MacBook с поддержкой стилуса Apple Pencil.",
                               description:
                                """
                                Apple получила патент на механизм для крепления стилуса Apple Pencil над клавиатурой MacBook. В документе можно заметить, что стилус сможет работать в режиме сенсорной панели Touch Bar и заменит собой ряд функциональных клавиш.
                                Купертиновцы получили патент на новую систему крепления стилуса Apple Pencil к MacBook. В первом варианте, освещенном в документе, фиксатор стилуса находится над клавиатурой и удерживает стилус с помощью магнитов. При этом устройство может спокойно проворачиваться и заменять собой колёсико мыши для прокрутки. Также в Apple Pencil встроена система подсветки и сенсорная панель, что позволяет выводить на корпус стилуса некоторые функциональные клавиши.
                                Механизмы фиксации
                                Механизмы фиксации
                                Поимо всего этого, в документе можно найти вариант фиксации Apple Pencil на нижней части MacBook под клавиатурой и в специальном углублении справа. В этих случаях устройство все также удерживают магниты. В некоторых случаях, как описала компания, Apple Pencil может вибрировать в ответ на нажатия.
                                Подсветка функциональных клавиш и тактильная отдача
                                Подсветка функциональных клавиш и тактильная отдача
                                Пользователи и журналисты успели прокомментировать новый патент компании. Часть из них отметила, что продукты Apple активно используются школьниками и студентами, поэтому связь фирменного стилуса и ноутбука им будет полезна. Другие заметили, что только недавно IT-гигант отказался от сенсорной панели с функциональными клавишами и теперь опять собирается вернуть ее, но в другом виде.
                                
                                """,
                               image: "daniilshat",
                               likes: 264,
                               views: 584))
        
        model.append(PostModel(author: "hello_hella. Минцифры занялось разработкой механизма совместного использования операторами их сотовых сетей.",
                               description:
                                """
                                Власти намерены предложить операторам связи совместно использовать сотовые сети в небольших населённых пунктах и на автотрассах. Минцифры разрабатывает такой механизм, пишут «Известия» со ссылкой на три источника на рынке связи. В ведомстве подтвердили информацию.
                                По словам собеседников издания, схема должна выглядеть так: если оператор, к примеру, покрывает удалённый населенный пункт, а у конкурентов в нём нет сетей, для обслуживания абонентов там они смогут воспользоваться оборудованием уже телефонизировавшей его компании. Как уточнил один из систочников, такая кооперация необходима, чтобы реализовать социально значимые проекты, затормозившиеся из-за санкций. Среди них — упразднение в РФ цифрового неравенства, а также покрытие мобильным интернетом федеральных автотрасс.
                                Другой собеседник «Известий» на рынке связи рассказал, что разработку механизма совместного использования сетей Минцифры начало ещё в 2021 году. Тогда Госкомиссия по радиочастотам определила условия продления разрешений на использование частот для мобильного интернета четвертого поколения (LTE) на десять лет. Это развертывание сетей 4G в 99% населенных пунктов с населением 500-999 человек к 2028 году, а также покрытие мобильным интернетом 99% федеральных автотрасс к 2030-му. При этом с 2023 года операторы должны были бы использовать для этого только российское оборудование.
                                В России около 5 тыс. населённых пунктов с населением 500-999 человек, покрытие каждого стоит 3-7 млн рублей в зависимости от состояния имеющейся в них инфраструктуры. То есть установка в каждом из них по одной базовой станции LTE может обойтись в 15-35 млрд рублей, подсчитывали ранее участники рынка.
                                Механизм совместного использования сетей операторами действительно прорабатывают, подтвердили «Известиям» в Минцифры. Там добавили, что нарушение логистических цепочек привело к временному дефициту современного телекоммуникационного оборудования.
                                «Рост его стоимости существенно увеличил затраты на выполнение условий выделения LTE-частот для операторов. Это, в свою очередь, могло привести к существенному росту стоимости связи для граждан. Мы сочли важным поддержать обращение операторов и отложить исполнение условий предоставления LTE-частот на год, до стабилизации ситуации с поставками современного телекоммуникационного оборудования», — отметили в пресс-службе ведомства.
                                По словам одного из собеседников «Известий», схема совместного использования сетей актуальна не только для покрытия трасс и небольших населенных пунктов. Механизм технического роуминга в долгосрочной перспективе мог бы смягчить последствия отключений.
                                """,
                               image: "hello_hella",
                               likes: 169,
                               views: 584))
        
        
        return model
    }
    
}

//public var photos = ["3dwall01", "3dwall02", "3dwall03", "3dwall04", "3dwall05", "3dwall06", "3dwall07", "3dwall08", "3dwall09", "3dwall19", "3dwall11", "3dwall12", "3dwall13", "3dwall14", "3dwall15", "3dwall16", "3dwall17", "3dwall18", "3dwall19", "3dwall20"]



public var images: [UIImage] = [UIImage(named: "3dwall01")!,
                                UIImage(named: "3dwall02")!,
                                UIImage(named: "3dwall03")!,
                                UIImage(named: "3dwall04")!,
                                UIImage(named: "3dwall05")!,
                                UIImage(named: "3dwall06")!,
                                UIImage(named: "3dwall07")!,
                                UIImage(named: "3dwall08")!,
                                UIImage(named: "3dwall09")!,
                                UIImage(named: "3dwall19")!,
                                UIImage(named: "3dwall11")!,
                                UIImage(named: "3dwall12")!,
                                UIImage(named: "3dwall13")!,
                                UIImage(named: "3dwall14")!,
                                UIImage(named: "3dwall15")!,
                                UIImage(named: "3dwall16")!,
                                UIImage(named: "3dwall17")!,
                                UIImage(named: "3dwall18")!,
                                UIImage(named: "3dwall19")!,
                                UIImage(named: "3dwall20")!,
]

