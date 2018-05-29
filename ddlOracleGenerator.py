import random

rooms_in_cinemas = {"'Арсенал'": [8, "NULL"],
                    "'Kinopark 7 IMAX Keruen'": [7, "NULL"],
                    "'Kinopark 6 Keruencity Astana'": [5, "NULL"],
                    "'Chaplin Khan Shatyr'": [9, "NULL"],
                    "'Евразия Cinema7'": [8, "NULL"],
                    "'Арман (Азия Парк) 3D'": [7, "NULL"],
                    "'Kinopark 8 IMAX Saryarka'": [6, "NULL"],
                    "'Chaplin MEGA Silk Way'": [12, "NULL"],
                    }


# ################################################################
# ##########                    CINEMA                  ##########


def gen_cinema():
    data = []
    # кинотеатры, количество залов, адрес, рейтинг
    for elem in rooms_in_cinemas.keys():
        data.append([elem,
                     rooms_in_cinemas[elem][0],
                     rooms_in_cinemas[elem][1],
                     float("{0:.2f}".format(random.random() * 5))])
    return data


def ddl_cinema_writer(f):
    data = gen_cinema()
    for line in data:
        f.write('INSERT INTO Cinema VALUES (')
        n = len(line)
        for i in range(n - 1):
            f.write(str(line[i]) + ', ')
        f.write(str(line[n - 1]) + ');\n')
    f.write('\n\n\n')


# ################################################################
# ##########                      FILM                  ##########


# [НАЗВАНИЕ, ДЛИТЕЛЬНОСТЬ, РЕЙТИНГ, ЖАНР, ВОЗРАСТ]

def gen_film(num):
    word1 = ["'Убийственное", "'Неповторимое", "'Неуловимое",
             "'Невообразимое", "'Непобедимое", "'Забытое", "'Сумашедшее",
             "'Героическое", "'Пустое", "'Немыслимое", "'Ужасающее",
             "'Невыносимое", "'Прощальное", "'Последнее"]
    word2 = ["'", " убийство'", " преступление'", " расследование'",
             " веселье'", " измерение'", " таинство'", " счастье'", " желание'",
             " прощение'", " удовольствие'", " забвение'", " знание'",
             " ранение'", " письмо'", " событие'"]
    word3 = ["'комедия'", "'ужасы'", "'драма'", "'приключение'", "'фантастика'"]
    word4 = [0, 3, 6, 18]
    data = []
    st = set()
    name = random.choice(word1) + random.choice(word2)

    # фильм, длительность, рейтинг, жанр, возраст
    for i in range(num):
        while name in st:
            name = random.choice(word1) + random.choice(word2)
        st.add(name)
        data.append([name,
                     "'{}:{}'".format(random.randint(1, 2), random.randint(0, 59)),
                     float("{0:.2f}".format(random.random() * 5)),
                     random.choice(word3),
                     random.choice(word4)
                     ])
    return data


def ddl_film_writer(f):
    print("Пожалуйста введите количество фильмов:")
    num = int(input())
    data = gen_film(num)
    for line in data:
        f.write('INSERT INTO Film VALUES (')
        n = len(line)
        for i in range(n - 1):
            f.write(str(line[i]) + ', ')
        f.write(str(line[n - 1]) + ');\n')
    f.write('\n\n\n')
    return data


# ################################################################
# ##########                      ROOM                  ##########


# [КИНОТЕАТР, НОМЕР ЗАЛА В КИНОТЕАТРЕ, КОЛИЧЕСТВО МЕСТ]

def gen_room():
    places = [16, 25, 36, 49, 64]
    data = []

    # кинотеатр, номер зала, количество мест
    for elem in rooms_in_cinemas.keys():
        for i in range(rooms_in_cinemas[elem][0]):
            data.append([elem,
                         i + 1,
                         random.choice(places)])
    return data


def ddl_room_writer(f):
    data = gen_room()
    for line in data:
        f.write("INSERT INTO Room VALUES (")
        n = len(line)
        for i in range(n - 1):
            f.write(str(line[i]) + ', ')
        f.write(str(line[n - 1]) + ');\n')
    f.write("\n\n\n")
    return data


# ################################################################
# ##########                     PLACE                  ##########


# НОМЕР МЕСТА, НОМЕР ЗАЛА В КИНОТЕАТРЕ, НАЗВАНИЕ КИНОТЕАТРА
# НОМЕР РЯДА, НОМЕР СТОЛБЦА

def gen_place(rooms):
    data = []

    # номер места, номер зала, кинотеатр, номер ряда, номер стобца
    for elem in rooms:
        for i in range(elem[2]):
            data.append([i + 1,
                         elem[1],
                         elem[0],
                         "dbo.GetRowNumber({}, {}, {})".format(i + 1, elem[1], elem[0]),
                         "dbo.GetColumnNumber({}, {}, {})".format(i + 1, elem[1], elem[0])])
    return data


def ddl_place_writer(f, rooms):
    data = gen_place(rooms)
    for line in data:
        f.write("INSERT INTO Place VALUES (")
        n = len(line)
        for i in range(n - 1):
            f.write(str(line[i]) + ', ')
        f.write(str(line[n - 1]) + ');\n')
    f.write("\n\n\n")
    return data


# ################################################################
# ##########                   SESSION                  ##########


# НОМЕР ЗАЛА В КИНОТЕАТРЕ, НАЗВАНИЕ КИНОТЕАТРА
# НАЗВАНИЕ ФИЛЬМА, НАЧАЛО, --КОНЕЦ--


def gen_session(films, rooms):
    data = []

    for room in rooms:
        clock = 0
        while clock < 1440:
            film = random.choice(films)
            durability = film[1].split(':')

            minutes_len = len(durability[1])
            dur_hours = int(durability[0][1:])
            dur_minutes = int(durability[1][0:minutes_len - 1])

            if clock + dur_hours * 60 + dur_minutes < 1440:
                start = "'26-06-2018 {}:{}:00'".format(clock // 60, clock % 60)
                clock += dur_hours * 60 + dur_minutes
                end = "'26-06-2018 {}:{}:00'".format(clock // 60, clock % 60)
                data.append([room[1],
                             room[0],
                             film[0],
                             start,
                             end])

            clock += 15

    return data


def ddl_session_writer(f, films, rooms):
    data = gen_session(films, rooms)
    for line in data:
        f.write("INSERT INTO Session_ VALUES (")
        n = len(line)
        for i in range(n - 1):
            f.write(str(line[i]) + ', ')
        f.write(str(line[n - 1]) + ');\n')
    f.write("\n\n\n")
    return data


# ################################################################
# ##########                   ORDER_                   ##########

# НОМЕР МЕСТА, НОМЕР ЗАЛА, НАЗВАНИЕ КИНОТЕАТРА
# НАЧАЛО СЕАНСА, ИМЯ ПОКУПАТЕЛЯ, БРОНЬ, ПОКУПКА,
# НАЗВАНИЕ ФИЛЬМА, ЦЕНА


def gen_order(places, sessions, bron):
    data = []
    ses = []

    place = random.choice(places)
    good_sessions = []
    for session in sessions:
        if session[0] == place[1] and session[1] == place[2]:
            good_sessions.append(session)
    chosen_session = random.choice(good_sessions)

    for i in range(bron):

        while True:
            place = random.choice(places)
            good_sessions = []
            for session in sessions:
                if session[0] == place[1] and session[1] == place[2]:
                    good_sessions.append(session)
            chosen_session = random.choice(good_sessions)
            if [place, chosen_session] not in ses:
                break

        ses.append([place, chosen_session])
        is_reserved = random.choice([0, 1])
        is_bought = 0

        if is_reserved == 1:
            is_bought = 0
        else:
            is_bought = 1

        data.append([place[0],
                     place[1],
                     place[2],
                     chosen_session[3],
                     "NULL",
                     is_reserved,
                     is_bought,
                     chosen_session[2],
                     # кинотеатр, зал, место, начало фильма
                     "dbo.GetPrice({}, {}, {}, {})".format(place[2], place[1],
                                                           place[0],
                                                           chosen_session[3])])
    return data


def ddl_order_writer(f, places, sessions):
    print("Пожалуйста, введите количество забронированных/купленных мест:")
    bron = int(input())

    data = gen_order(places, sessions, bron)

    for line in data:
        f.write("INSERT INTO Order_ VALUES (")
        n = len(line)
        for i in range(n - 1):
            f.write(str(line[i]) + ', ')
        f.write(str(line[n - 1]) + ');\n')
    f.write("\n\n\n")


# ################################################################
# ##########                      MAIN                  ##########


def main():
    f = open('/home/aleksiks/prog/BD/ddls/OracleCreation-ddl.sql', 'w')
    ddl_cinema_writer(f)
    films = ddl_film_writer(f)
    rooms = ddl_room_writer(f)
    places = ddl_place_writer(f, rooms)
    sessions = ddl_session_writer(f, films, rooms)
    ddl_order_writer(f, places, sessions)
    f.close()


main()
