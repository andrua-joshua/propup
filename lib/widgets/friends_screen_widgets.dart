import 'package:flutter/material.dart';
import 'package:propup/routes.dart';

///
///this is where all the custom widgets of the friends screen are to be defined
///
//ignore:camel_case_types
class friendsTitleWidget extends StatelessWidget {
  const friendsTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        const Text(
          "My Friends (580)",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromARGB(255, 68, 221, 255)),
          padding: const EdgeInsets.fromLTRB(15, 3, 15, 5),
          child: const Text(
            "Add friends",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        )
      ],
    );
  }
}

///
///custom widget for holding all the friends in the friends screen grid
///
//ignore: camel_case_types
class gridDataWidget extends StatelessWidget {
  final String name;
  final String title;
  const gridDataWidget({required this.name, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        //color: Colors.white,
        child: GestureDetector(
          onTap: () =>
              Navigator.pushNamed(context, RouteGenerator.friendprofilescreen),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Column(
              children: [
                Container(
                  height: 110,
                  width: 110,
                  margin: const EdgeInsets.only(top: 10),
                  child: const CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(
                        "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIAKYAzAMBIgACEQEDEQH/xAAcAAACAgMBAQAAAAAAAAAAAAAEBQMGAAIHAQj/xAA+EAABAwIEBAMFBQcDBQEAAAABAAIDBBEFEiExBiJBURNhcQcUMoGxI0KRocEVQ1JicoLRM6KyJVPC4fAW/8QAGQEBAQEBAQEAAAAAAAAAAAAAAQACAwQF/8QAHxEBAQACAgMAAwAAAAAAAAAAAAECEQMxEiFBBCIy/9oADAMBAAIRAxEAPwBPGUTG+yDZdTMJUjCN9wpmPym7TqgmEqUOKDtYsPxHLYONlZqKqbK0agrnjHFNaCvkgeNeValZsdAY3NqApAxLMJxRlQACQnYAIBGyVornZesj8gSpvDW2S9c7yap8igHEYWRR3qHns0IkMWQNvLKfOyi8yaLWNm6JLeUryJikgcy5XpYpSOZekBSReHovQxTWsBoV7YdNVIOY1qWBEWXmVSQeGOy8MaJyrUtUkBj0S2rZunJbollYNSi9GI8NZ9oUxezmQmGN+0KYvHMiHJwprFK1i9aFOxig1Y0qZsbj0W7GahMYIQW7KRaGkHUIiI3IRzqUEbKMUxa7QIPoVRSOa67ND5K1YVi9rRzm3Yqs0kZBTSKPQK2dLPSlss8kjSC021ROVVSmrZ6OYmM3aTq09VYqDEoKsWP2cn8J6+iZkzoUAtaZujz3eVPbTVaUrfsWu6m5SGPFmrGDRbyfCqtx3xDNgOGAUzLTVDS2Oa4tE63Uf/bKRdxTx6zh/EnUn7PfOWEZi2S2lr9lSca9oGJSzO93dJHBINmN1Gt9VV8QxXEK2CeqxGUuqpJLZ2j4hbdIKieT3gyk89t/MBG2tLzR+0HFafDvEdO6/jtMZkJzaCxHmD2XQ+F/aTheNeBTHxI6pzXGUyANZEG7lzv0Hf1t89TVMs7yJbuaOhXsVU5j2AHlbq0E6BW1p9dRubJG17HBzHC7XDUELayp3s04lfj+ExsMeUU0QjdI51jI8b2H8O2quYC0y8DVmVbrFbSNw0JSqsbqm7xypTV6lF6M7SYW3nKYObqg8LHMUe4aonRy7cMY1ExsWsbUVGzRQYxtiEyp3ADVBsZqmMEV26hCTMc09luGNK9bEOylbEOykyGJoKPiby6IVsPUKRudnVFjW3jm3eSe6nijsy9lqGg65kXFbYEEKkWxlLXSwx5ZSZGAaX3Ca0ksckEeRwNhqEmsDGQLiymgaWC7TqtMnEnYLkHtdM3/AOjpmxAi9M29xo7Vy6iyrc084Jsqnx3SwVGKYZWuawkRvZztcWnUEbddSq30cZuqVwhwicbqz7/y0zG3c0C1z5K/M4QwDDqctioYSNb52hx/NFYTPFSU73VMjWAAaloaPwCU4nxZhOsTKsOeTaxYW2/Fcbn6teiYXy0ruL4ZhvjODaSEM8owqDjnD9OXPfRDw3i5yjZX2rlM7zlvlOt1Wq9uWcc4udxmXmxzvl6evPjx17aexKKtdxm3wAfDihcag22btb5n6L6HC517HMLbT0uK12WxqJw1pt91oB+pK6OAvdPcfMymq8svQF7ZZZaZaSbJPVfEU5k+FKKgXeVm9N4diMLGpTBw1QeGCzSeqNdurHpZ9uLRMRUbNFrExEtbolllOzM5N4IbM2QVGy7gnccXKEoMI7KVrFOI16I0JEGr1w5SpgxaStsLd1JG1gsFmWx8kT4dgtcik1jkka4DMS3sUdHUWFihGt5wFMWaKQkTByqGKSuk4hmp53Sy5ntdEwO+zija0XNu5ddWZjNUnxyjqDIJ6eHxCbZyDzDoflbX5Llyy2enfguMy9oMVNXPSF2H+E58e3iHQeduqoGIVuIy1r/ewXua4BjGwmxHW5O3TuugUmKsoAbDN5XSiTFaSrxZuUR04uTJLbRoA/VcPKdPV4W+yvGTNhmHU0xBL5tLDoqhVzh0jzLRRPY0AudqXEkgW2tfUnXsV0XjKpocRw2nbSvbJ4ZuXA8t7qstignpzIY2Olj0udSsy441q43KOoey1rG8KsDfg8eTKb3uLq4iyoXAT5KTh2Nr2kB0r3Nv2JVnjrwvbh/MfN5P6psvUubXAqVtY3utaAmX4UrmjdmNhdGOqmnqvGkO1CzZs43V21w5pAOYWRZ3WsIGq2KZNC+65PE1ThvKtYgpiOVST4exPI2coSrDm7J2xtgEwNMq9yqWy2yq0kOXRRvbzs9UVl0UeUeOwfNCeuYtSxFFq1LVFDFHeVvopjGtoGjxif5VO5uidANHHosdFcFp0DgQiY26Fe5L69O6tKduQ8RMlglqosxZI27Rbuh+HKKpqGSsdGwjKSLv+Ielv1TXjUOGMVDni3Pr6dEDC+SOEOpzd24AOq8eWsbX0sP2kQYtw3U01O+SeUQxA6EVDSDpfa1+iR4R7zU18bI8/wBoQ0MIF3XNheya1lbPI0smBd89k09mzsOONzSVf+rAAI3W5WE9fw0v0RhN0cuXjNumQ03hwxxDZjQ38At/d0a2MHZSCNe2Pnl/gWWCE30TAxr0R6pBa6NzXb2Ukcrmi2ZTzttdCLFrphNmlC8vY6+qJO6Dw3/TKLdumMVzCMKV45RdaRhbydEoww5ugTho0CV4eNAmrUwVuAtrLAtrKTy2ihaL1YHZqJtooYBepeewVpJ7LA3XTdb2usDTcWVpMDHQxSTlt29goBWiRgexujm3R8rgGup3DQtsPI2SCmd4T307vuv09CpD21BLdFtRVBmL77ZtAgpi6CRw+7deYVUROlMTX87CS9p0IuSfwUKq3tCpxFWwVH3Zm+Ge2Yaj8voqY5s0D80bnBp7HRdP44oRX4HUtaOZrPEYfMahc3hzGJudu4Xh55419D8W+U0V1c1Q4ZS4W62CM4Ev+18Rb0EcZP8AuXtVBzaBGcE0pjxjEHEaOhZ+Rcjhy3k3+RP12utPiFVEGsEr8rduZOKPGJ2sGd2b1SUQm9rKalaMu97EgL2PnaWeDEhIBmai6WqZPLIzZzOnkq/DcBQQVRgxCKRpIs27rdRZa2lnqhYFBEImWVskbXxuu1wu0+SguLLOTeHQ3DdIyi3boXD/AISiDumM5ObRLZ+pC1iWbvSyb4eOUJm3ZLqD4AmDdkxJmlbhRgqQKTbooqTV8rvOykO11HRatce7lISFNStzSg/wi6hCLpNGPdbyUgeJvs4vj+Jm4HUJHUEeMJmG7SL3HXzR+JymN5dm5RufLzSeOUCeSmJ5XMMkf6hFRpVfa0scrfiKgw8R6Shg8UAsc46lTUJLsMYTuHEKJg8KZ1uoUBczRLG+N+zgW/kuTQVdNLNLSCUMqKd5jfE42IsbbLq7XXZd3VfPPtIpvdeNq8NzDxC2UO2IuOi58mEzjtw8t46u0jI2tJkdayzhDFKWXiw0MEjXl9K+9trgtP0uqXUmWu4HppJa5pfRSycpcLuDntAY43uX7uAsbtB10Q/AE7aPjPCJDoHTGI/3tLfqVy4+CY3drryfkXOa0734LSCvDG2ERNaOUXCIg2N+i8rW3dENrk/RejTzN2HKy4SCnlL4ZJgdfBDR6kWTpriWW622VbpnudTPZcACQ3t0ARStmDyg4a2HNd0QGnYHb6KbM7ukeCzFuIOY4ZRKzRt9rbD8E+yklZtdMejLDL+HqiHHVQYcLMUzjqtxzy7c3jNl603kWjCsiN5fmlk+ofgCOaUBRnkCMaUgQCpAVA0qZpUmzzZhPZeUf+g3zK0ndaJ5/lK3pRlgYPJSEDRH2yU4Gm1zdCUbPEmv91ouVLXTENsA0DoXKV6I8TfmcS300CrMTjHjdO1usT2SZbH4Tbb0KdYlLI53M8nXpokRyfteikOjmucPUELP0/Fsw5v/AEpv9RUMjbkP7ImgI/Z7WjexP5qE6tIWgy4F2723XGfbNS+Hj1DUjaemLfUtd/hwXXzIcoNt9Pmua+2mnDsPwqqtZ0dQ+O/k5t//AAQY53g7RM2vpXC5lpHPZb/uR87fyDh80LQVBpsTpKlhsYpmPB9HBTYJUCnxeklPw+MGuHcO0P1QlVAaWonp+sUjo7/0m36IL6fhc1zyRsdR6LTEXZX0v9bh+RQnD9QKrC6GdpB8SmjN/kERizTem20l/RPwAHTyRsdrzgpbggaWyuawAiV5Gbvc6o6tFpn5TuUtwx0oqqmJjdGyaa73APy3WJ23ehrpPAq4pBzPDhYdSrQx92tIOhF1VaiCUA3FrixLTrZWLCHe90Ecua7hyu9Qiw45aPMPP2alduoaFpZHqpHHmXSRm3bmzTospjeUqPNyXW1KedTKwUptGEW0oCA2YEUxyWaKaVK1yFa5StcpNqx9oHDvop4tI2jyQNY67Wt7uCNj5i1o3JtZJN6NvhwZurtUtxKbdNJ3CKINHQWVaxKoGuoQiuuk599UsEDzMKv91FIGX8ypKqou4m+yc11J7rwhGXN+1lkZIR1uT/iyzO2h+GkeG0dPDH+V46wDgoqF+UNF7gNAWz3albrIQu5nN88w+n+FSfa40ScKlx1MU8bwexvb9VcJ5MkrXX0BsfQqm+091+Earykj/wCYWK1HHA5zHBzNwbj1CZcQhhxV8zDy1DGTN/ubr+YKVA/gmOJ89Dhc5G8Doj/Y4tCi7b7NaoVHCGGOBuYmGI+rTZP8aeA2nt/H+i577GsQMmFV1CXc1POHhvZrh/kFXfGptKYE/fP0TemfoWrla2wJvdKsCmviuIAn94P+IXtXUN8TLfql+CS2xuuF95f0BXOdt3pbZtW+qm4VqRBiEtO88szbgeY/9Idxuy/kl5nNLWw1Df3bgT6LbLpEdg2yjc7mUdJKJI8w2IuF45wutBzRz+RSUbuZAySciJoH7ISwwu5QiGPS+N+gU7XpZHNepmvQDXqZr9FKJKh2aaBv8100w856yNvY3/C5SF0l6yMdgSjojJMTFC8xukGQuG4BIvbztdJMsVxGnYfDzySOJIDIup7XVbqGPqJHAUssdjbmlvc9k7ZHDTTPmYAC0ZIgNmNHb6rRga1xO5OhPZRVj9nVL8WpqZ0DxTzOAfIZAQ0db9tFZ+IKj3ullZFpHHY6eRWsmU3Q7nWjfEPheLG/RHigtFOLgbcqIfMHAkHqk1pqYlrwcvRwW8dRZuW97LTP1NWEvfkb1VO9pUl+EqvzfEf94VqNQ3NzKke0ua3Dckf8c7QPTNdYsbjlYN9U1qCJOGqJ2Zl46qVtr6gEAjTte6SNcWny6rckXu3UIK8eybEPduJnUpdZtZA5tu7m8w/LMuoY/Nz0Tf53X89FwLBa92HYxRVrSbwTtefMX1HzC7PxLiEbX0JuMpzOBHW4Gqr0PpXiFQYJHPcTob7obAK5stfNK37zhr/aAh6+d1ZMYommQuHwgXui+HOFZ6UvlqZCxj3ZmxN3HqUSK1c2Sl0YIO46lBVxvGSb26kbL0shhALgCQLXI1/FLK6pjY0mFrc46knUdr9E2KV0bhurbU4NTSXu/Jld6g2P0Rj38xVQ9n9d4lNV0+ckseJAHdnC31arM6TVMTlkkhyhH0D9AvFigbsebBTNkKxYtMpmSFTNkKxYpQOx5NcT2YmFPUGGVjwvFiDUtVWHtotDUFkdwsWJhRipc5eeK5zrDRYsSHskTjGS+U5bbAXSciCSUthMgcNyQAFixCA4lTVEUkd5GlkhDRa9wqx7Wab3bh6iOcuL6u3yDCsWIvRjlC9BsVixZIvDqKXEa6GkhcxskzwxpeTYE+i7dT8OQe5UkOLuNVLTRiMOYSwHTtdYsWoKKip6PDWkUlMxg2cdyfmo5MR0IY0grFiEUVdc8kpZJM517rFizWovnA1LHT4cakC80+pd2AJsE/e+7l4sW4K//9k="),
                  ),
                ), // for holding the profile pic

                const SizedBox(
                  height: 10,
                ),
                statusWidget(
                  name: name,
                  online: true,
                ),
                Text(
                  title,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                )
              ],
            ),
          ),
        ));
  }
}

///
///for holding the name and the online status
///
//ignore: camel_case_types
class statusWidget extends StatelessWidget {
  final String name;
  final bool isOnline;
  const statusWidget({required this.name, bool online = false, super.key})
      : isOnline = online;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 7,
          width: 7,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isOnline ? Colors.green : Colors.grey),
        ),
        Text(
          name,
          style: const TextStyle(color: Colors.black, fontSize: 17),
        )
      ],
    );
  }
}
