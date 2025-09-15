"
I test the STSkillCornerConverter with SkillCorner examples provided [here](https://github.com/SkillCorner/opendata/tree/master/data/matches).
"
Class {
	#name : 'STSkillCornerTest',
	#superclass : 'TestCase',
	#instVars : [
		'matchData2068',
		'match4039Converter',
		'matchData4039'
	],
	#category : 'SoccerTheory-SoccerML-Tests',
	#package : 'SoccerTheory-SoccerML-Tests'
}

{ #category : 'fixtures' }
STSkillCornerTest >> jsonMatchData2068 [
	"Answer metadata for match number 2068."

	^ ReadStream on:
		  '{"referees": [{"first_name": "Gianluca", "referee_role": 0, "start_time": "00:00:00", "trackable_object": 11180, "last_name": "Rocchi", "end_time": null, "replaced_by": null, "id": 16}], "date_time": "2019-10-06T18:45:00Z", "home_team": {"acronym": "INT", "id": 145, "short_name": "Inter", "name": "Inter Milan"}, "away_team": {"acronym": "JUV", "id": 139, "short_name": "Juventus", "name": "Juventus"}, "away_team_kit": {"jersey_color": "#000000", "name": "home", "season": {"name": "2017/2018", "id": 4, "end_date": "2018-07-31", "start_date": "2017-08-01"}, "team_id": 139, "number_color": "#ffffff", "id": 58}, "home_team_coach": {"first_name": "Antonio", "last_name": "Conte", "id": 814}, "status": "closed", "pitch_length": 105, "players": [{"injured": false, "own_goal": 0, "last_name": "de Vrij", "goal": 0, "red_card": 0, "number": 6, "id": 9972, "trackable_object": 9982, "team_id": 145, "birthday": "1992-02-05", "end_time": null, "first_name": "Stefan", "player_role": {"acronym": "CB", "id": 2, "name": "Center Back"}, "start_time": "00:00:00", "yellow_card": 0, "team_player_id": 7446}, {"injured": false, "own_goal": 0, "last_name": "Skriniar", "goal": 0, "red_card": 0, "number": 37, "id": 7638, "trackable_object": 7648, "team_id": 145, "birthday": "1995-02-11", "end_time": null, "first_name": "Milan", "player_role": {"acronym": "LCB", "id": 3, "name": "Left Center Back"}, "start_time": "00:00:00", "yellow_card": 0, "team_player_id": 4713}, {"injured": false, "own_goal": 0, "last_name": "D''Ambrosio", "goal": 0, "red_card": 0, "number": 33, "id": 2286, "trackable_object": 2296, "team_id": 145, "birthday": "1988-09-09", "end_time": null, "first_name": "Danilo", "player_role": {"acronym": "RW", "id": 13, "name": "Right Winger"}, "start_time": "00:00:00", "yellow_card": 0, "team_player_id": 2801}, {"injured": false, "own_goal": 0, "last_name": "Barella", "goal": 0, "red_card": 0, "number": 23, "id": 8042, "trackable_object": 8052, "team_id": 145, "birthday": "1997-02-07", "end_time": null, "first_name": "Nicolo", "player_role": {"acronym": "RM", "id": 10, "name": "Right Midfield"}, "start_time": "00:00:00", "yellow_card": 1, "team_player_id": 21708}, {"injured": false, "own_goal": 0, "last_name": "Higuain", "goal": 1, "red_card": 0, "number": 21, "id": 4013, "trackable_object": 4023, "team_id": 139, "birthday": "1987-12-10", "end_time": null, "first_name": "Gonzalo", "player_role": {"acronym": "AM", "id": 11, "name": "Attacking Midfield"}, "start_time": "01:01:18", "yellow_card": 0, "team_player_id": 4368}, {"injured": false, "own_goal": 0, "last_name": "Can", "goal": 0, "red_card": 0, "number": 23, "id": 3094, "trackable_object": 3104, "team_id": 139, "birthday": "1994-01-12", "end_time": null, "first_name": "Emre", "player_role": {"acronym": "LF", "id": 14, "name": "Left Forward"}, "start_time": "01:10:29", "yellow_card": 1, "team_player_id": 7691}, {"injured": false, "own_goal": 0, "last_name": "Vecino", "goal": 0, "red_card": 0, "number": 8, "id": 7199, "trackable_object": 7209, "team_id": 145, "birthday": "1991-08-24", "end_time": null, "first_name": "Matias", "player_role": {"acronym": "LM", "id": 9, "name": "Left Midfield"}, "start_time": "00:33:22", "yellow_card": 1, "team_player_id": 4711}, {"injured": false, "own_goal": 0, "last_name": "Politano", "goal": 0, "red_card": 0, "number": 16, "id": 7236, "trackable_object": 7246, "team_id": 145, "birthday": "1993-08-03", "end_time": null, "first_name": "Matteo", "player_role": {"acronym": "LF", "id": 14, "name": "Left Forward"}, "start_time": "01:17:06", "yellow_card": 0, "team_player_id": 7454}, {"injured": false, "own_goal": 0, "last_name": "Bentancur", "goal": 0, "red_card": 0, "number": 30, "id": 11287, "trackable_object": 11322, "team_id": 139, "birthday": "1997-06-25", "end_time": null, "first_name": "Rodrigo", "player_role": {"acronym": "RM", "id": 10, "name": "Right Midfield"}, "start_time": "01:01:01", "yellow_card": 0, "team_player_id": 4409}, {"injured": false, "own_goal": 0, "last_name": "Bastoni", "goal": 0, "red_card": 0, "number": 95, "id": 19047, "trackable_object": 19244, "team_id": 145, "birthday": "1999-04-13", "end_time": null, "first_name": "Alessandro", "player_role": {"acronym": "RCB", "id": 4, "name": "Right Center Back"}, "start_time": "00:53:38", "yellow_card": 0, "team_player_id": 22261}, {"injured": false, "own_goal": 0, "last_name": "Bernardeschi", "goal": 0, "red_card": 0, "number": 33, "id": 3333, "trackable_object": 3343, "team_id": 139, "birthday": "1994-02-16", "end_time": "01:01:18", "first_name": "Federico", "player_role": {"acronym": "AM", "id": 11, "name": "Attacking Midfield"}, "start_time": "00:00:00", "yellow_card": 0, "team_player_id": 7694}, {"injured": false, "own_goal": 0, "last_name": "Rabiot", "goal": 0, "red_card": 0, "number": 25, "id": 277, "trackable_object": 287, "team_id": 139, "birthday": "1995-04-03", "end_time": null, "first_name": "Adrien", "player_role": {"acronym": "SUB", "id": 17, "name": "Substitute"}, "start_time": null, "yellow_card": 0, "team_player_id": 21466}, {"injured": false, "own_goal": 0, "last_name": "Dybala", "goal": 1, "red_card": 0, "number": 10, "id": 8504, "trackable_object": 8514, "team_id": 139, "birthday": "1993-11-15", "end_time": "01:10:29", "first_name": "Paulo", "player_role": {"acronym": "LF", "id": 14, "name": "Left Forward"}, "start_time": "00:00:00", "yellow_card": 0, "team_player_id": 354}, {"injured": false, "own_goal": 0, "last_name": "Godin", "goal": 0, "red_card": 0, "number": 2, "id": 2705, "trackable_object": 2715, "team_id": 145, "birthday": "1986-02-16", "end_time": "00:53:38", "first_name": "Diego", "player_role": {"acronym": "RCB", "id": 4, "name": "Right Center Back"}, "start_time": "00:00:00", "yellow_card": 0, "team_player_id": 21706}, {"injured": false, "own_goal": 0, "last_name": "Matuidi", "goal": 0, "red_card": 0, "number": 14, "id": 1362, "trackable_object": 1372, "team_id": 139, "birthday": "1987-04-09", "end_time": null, "first_name": "Blaise", "player_role": {"acronym": "LM", "id": 9, "name": "Left Midfield"}, "start_time": "00:00:00", "yellow_card": 0, "team_player_id": 4367}, {"injured": false, "own_goal": 0, "last_name": "Martinez", "goal": 1, "red_card": 0, "number": 10, "id": 12643, "trackable_object": 12801, "team_id": 145, "birthday": "1997-08-22", "end_time": "01:17:06", "first_name": "Lautaro", "player_role": {"acronym": "LF", "id": 14, "name": "Left Forward"}, "start_time": "00:00:00", "yellow_card": 0, "team_player_id": 7453}, {"injured": false, "own_goal": 0, "last_name": "Ronaldo", "goal": 0, "red_card": 0, "number": 7, "id": 2073, "trackable_object": 2083, "team_id": 139, "birthday": "1985-02-05", "end_time": null, "first_name": "Cristiano", "player_role": {"acronym": "RF", "id": 16, "name": "Right Forward"}, "start_time": "00:00:00", "yellow_card": 0, "team_player_id": 7692}, {"injured": false, "own_goal": 0, "last_name": "Buffon", "goal": 0, "red_card": 0, "number": 77, "id": 3903, "trackable_object": 3913, "team_id": 139, "birthday": "1978-01-28", "end_time": null, "first_name": "Gianluigi", "player_role": {"acronym": "SUB", "id": 17, "name": "Substitute"}, "start_time": null, "yellow_card": 0, "team_player_id": 432}, {"injured": false, "own_goal": 0, "last_name": "Pinsoglio", "goal": 0, "red_card": 0, "number": 31, "id": 12767, "trackable_object": 12928, "team_id": 139, "birthday": "1990-03-16", "end_time": null, "first_name": "Carlo", "player_role": {"acronym": "SUB", "id": 17, "name": "Substitute"}, "start_time": null, "yellow_card": 0, "team_player_id": 7687}, {"injured": false, "own_goal": 0, "last_name": "Rugani", "goal": 0, "red_card": 0, "number": 24, "id": 2274, "trackable_object": 2284, "team_id": 139, "birthday": "1994-07-29", "end_time": null, "first_name": "Daniele", "player_role": {"acronym": "SUB", "id": 17, "name": "Substitute"}, "start_time": null, "yellow_card": 0, "team_player_id": 1015}, {"injured": false, "own_goal": 0, "last_name": "Ramsey", "goal": 0, "red_card": 0, "number": 8, "id": 95, "trackable_object": 105, "team_id": 139, "birthday": "1990-12-26", "end_time": null, "first_name": "Aaron", "player_role": {"acronym": "SUB", "id": 17, "name": "Substitute"}, "start_time": null, "yellow_card": 0, "team_player_id": 21467}, {"injured": false, "own_goal": 0, "last_name": "Sensi", "goal": 0, "red_card": 0, "number": 12, "id": 11271, "trackable_object": 11305, "team_id": 145, "birthday": "1995-08-05", "end_time": "00:33:22", "first_name": "Stefano", "player_role": {"acronym": "LM", "id": 9, "name": "Left Midfield"}, "start_time": "00:00:00", "yellow_card": 0, "team_player_id": 21704}, {"injured": false, "own_goal": 0, "last_name": "Demiral", "goal": 0, "red_card": 0, "number": 28, "id": 15046, "trackable_object": 15243, "team_id": 139, "birthday": "1998-03-05", "end_time": null, "first_name": "Merih", "player_role": {"acronym": "SUB", "id": 17, "name": "Substitute"}, "start_time": null, "yellow_card": 0, "team_player_id": 21465}, {"injured": false, "own_goal": 0, "last_name": "Handanovic", "goal": 0, "red_card": 0, "number": 1, "id": 9494, "trackable_object": 9504, "team_id": 145, "birthday": "1984-07-14", "end_time": null, "first_name": "Samir", "player_role": {"acronym": "GK", "id": 0, "name": "Goalkeeper"}, "start_time": "00:00:00", "yellow_card": 0, "team_player_id": 493}, {"injured": false, "own_goal": 0, "last_name": "Pjanic", "goal": 0, "red_card": 0, "number": 5, "id": 7670, "trackable_object": 7680, "team_id": 139, "birthday": "1990-04-02", "end_time": null, "first_name": "Miralem", "player_role": {"acronym": "CM", "id": 8, "name": "Center Midfield"}, "start_time": "00:00:00", "yellow_card": 1, "team_player_id": 4366}, {"injured": false, "own_goal": 0, "last_name": "Khedira", "goal": 0, "red_card": 0, "number": 6, "id": 9490, "trackable_object": 9500, "team_id": 139, "birthday": "1987-04-04", "end_time": "01:01:01", "first_name": "Sami", "player_role": {"acronym": "RM", "id": 10, "name": "Right Midfield"}, "start_time": "00:00:00", "yellow_card": 0, "team_player_id": 2243}, {"injured": false, "own_goal": 0, "last_name": "Sandro", "goal": 0, "red_card": 0, "number": 12, "id": 510, "trackable_object": 520, "team_id": 139, "birthday": "1991-01-26", "end_time": null, "first_name": "Alex", "player_role": {"acronym": "LWB", "id": 5, "name": "Left Wing Back"}, "start_time": "00:00:00", "yellow_card": 1, "team_player_id": 854}, {"injured": false, "own_goal": 0, "last_name": "Bonucci", "goal": 0, "red_card": 0, "number": 19, "id": 6169, "trackable_object": 6179, "team_id": 139, "birthday": "1987-05-01", "end_time": null, "first_name": "Leonardo", "player_role": {"acronym": "RCB", "id": 4, "name": "Right Center Back"}, "start_time": "00:00:00", "yellow_card": 0, "team_player_id": 7688}, {"injured": false, "own_goal": 0, "last_name": "de Ligt", "goal": 0, "red_card": 0, "number": 4, "id": 11559, "trackable_object": 11636, "team_id": 139, "birthday": "1999-08-12", "end_time": null, "first_name": "Matthijs", "player_role": {"acronym": "LCB", "id": 3, "name": "Left Center Back"}, "start_time": "00:00:00", "yellow_card": 0, "team_player_id": 21463}, {"injured": false, "own_goal": 0, "last_name": "Cuadrado", "goal": 0, "red_card": 0, "number": 16, "id": 5511, "trackable_object": 5521, "team_id": 139, "birthday": "1988-05-26", "end_time": null, "first_name": "Juan", "player_role": {"acronym": "RWB", "id": 6, "name": "Right Wing Back"}, "start_time": "00:00:00", "yellow_card": 0, "team_player_id": 700}, {"injured": false, "own_goal": 0, "last_name": "Szczesny", "goal": 0, "red_card": 0, "number": 1, "id": 10903, "trackable_object": 10913, "team_id": 139, "birthday": "1990-04-18", "end_time": null, "first_name": "Wojciech", "player_role": {"acronym": "GK", "id": 0, "name": "Goalkeeper"}, "start_time": "00:00:00", "yellow_card": 0, "team_player_id": 4408}, {"injured": false, "own_goal": 0, "last_name": "Esposito", "goal": 0, "red_card": 0, "number": 30, "id": 22196, "trackable_object": 22454, "team_id": 145, "birthday": "2002-07-02", "end_time": null, "first_name": "Sebastiano", "player_role": {"acronym": "SUB", "id": 17, "name": "Substitute"}, "start_time": null, "yellow_card": 0, "team_player_id": 18607}, {"injured": false, "own_goal": 0, "last_name": "Gagliardini", "goal": 0, "red_card": 0, "number": 5, "id": 9134, "trackable_object": 9144, "team_id": 145, "birthday": "1994-04-07", "end_time": null, "first_name": "Roberto", "player_role": {"acronym": "SUB", "id": 17, "name": "Substitute"}, "start_time": null, "yellow_card": 0, "team_player_id": 4710}, {"injured": false, "own_goal": 0, "last_name": "Candreva", "goal": 0, "red_card": 0, "number": 87, "id": 965, "trackable_object": 975, "team_id": 145, "birthday": "1987-02-28", "end_time": null, "first_name": "Antonio", "player_role": {"acronym": "SUB", "id": 17, "name": "Substitute"}, "start_time": null, "yellow_card": 0, "team_player_id": 4709}, {"injured": false, "own_goal": 0, "last_name": "Valero", "goal": 0, "red_card": 0, "number": 20, "id": 1405, "trackable_object": 1415, "team_id": 145, "birthday": "1985-01-12", "end_time": null, "first_name": "Borja", "player_role": {"acronym": "SUB", "id": 17, "name": "Substitute"}, "start_time": null, "yellow_card": 0, "team_player_id": 4708}, {"injured": false, "own_goal": 0, "last_name": "Lazaro", "goal": 0, "red_card": 0, "number": 19, "id": 17451, "trackable_object": 17648, "team_id": 145, "birthday": "1996-03-24", "end_time": null, "first_name": "Valentino", "player_role": {"acronym": "SUB", "id": 17, "name": "Substitute"}, "start_time": null, "yellow_card": 0, "team_player_id": 21707}, {"injured": false, "own_goal": 0, "last_name": "Ranocchia", "goal": 0, "red_card": 0, "number": 13, "id": 788, "trackable_object": 798, "team_id": 145, "birthday": "1988-02-16", "end_time": null, "first_name": "Andrea", "player_role": {"acronym": "SUB", "id": 17, "name": "Substitute"}, "start_time": null, "yellow_card": 0, "team_player_id": 7447}, {"injured": false, "own_goal": 0, "last_name": "Biraghi", "goal": 0, "red_card": 0, "number": 34, "id": 2067, "trackable_object": 2077, "team_id": 145, "birthday": "1992-09-01", "end_time": null, "first_name": "Cristiano", "player_role": {"acronym": "SUB", "id": 17, "name": "Substitute"}, "start_time": null, "yellow_card": 0, "team_player_id": 22262}, {"injured": false, "own_goal": 0, "last_name": "Dimarco", "goal": 0, "red_card": 0, "number": 21, "id": 19036, "trackable_object": 19233, "team_id": 145, "birthday": "1997-11-10", "end_time": null, "first_name": "Federico", "player_role": {"acronym": "SUB", "id": 17, "name": "Substitute"}, "start_time": null, "yellow_card": 0, "team_player_id": 22260}, {"injured": false, "own_goal": 0, "last_name": "Padelli", "goal": 0, "red_card": 0, "number": 27, "id": 2270, "trackable_object": 2280, "team_id": 145, "birthday": "1985-10-25", "end_time": null, "first_name": "Daniele", "player_role": {"acronym": "SUB", "id": 17, "name": "Substitute"}, "start_time": null, "yellow_card": 0, "team_player_id": 7443}, {"injured": false, "own_goal": 0, "last_name": "Lukaku", "goal": 0, "red_card": 0, "number": 9, "id": 9269, "trackable_object": 9279, "team_id": 145, "birthday": "1993-05-13", "end_time": null, "first_name": "Romelu", "player_role": {"acronym": "RF", "id": 16, "name": "Right Forward"}, "start_time": "00:00:00", "yellow_card": 0, "team_player_id": 21705}, {"injured": false, "own_goal": 0, "last_name": "Asamoah", "goal": 0, "red_card": 0, "number": 18, "id": 6014, "trackable_object": 6024, "team_id": 145, "birthday": "1988-12-09", "end_time": null, "first_name": "Kwadwo", "player_role": {"acronym": "LW", "id": 12, "name": "Left Winger"}, "start_time": "00:00:00", "yellow_card": 0, "team_player_id": 7452}, {"injured": false, "own_goal": 0, "last_name": "Brozovic", "goal": 0, "red_card": 0, "number": 77, "id": 6707, "trackable_object": 6717, "team_id": 145, "birthday": "1992-11-16", "end_time": null, "first_name": "Marcelo", "player_role": {"acronym": "CM", "id": 8, "name": "Center Midfield"}, "start_time": "00:00:00", "yellow_card": 0, "team_player_id": 3270}], "away_team_coach": {"first_name": "Maurizio", "last_name": "Sarri", "id": 40}, "ball": {"trackable_object": 55}, "pitch_width": 68, "competition_edition": {"season": {"name": "2019/2020", "id": 6, "end_date": "2020-07-31", "start_date": "2019-08-01"}, "id": 76, "competition": {"id": 5, "name": "Serie A", "area": "ITA"}, "name": "Serie A 2019-2020"}, "stadium": {"city": "Milan", "capacity": 80018, "id": 55, "name": "San Siro"}, "home_team_kit": {"jersey_color": "#151ebf", "name": "Home", "season": {"name": "2019/2020", "id": 6, "end_date": "2020-07-31", "start_date": "2019-08-01"}, "team_id": 145, "number_color": "#ffffff", "id": 1070}, "competition_round": {"potential_overtime": false, "round_number": 7, "id": 128, "name": "Round 7"}, "away_team_score": 2, "id": 2068, "home_team_score": 1}'
]

{ #category : 'fixtures' }
STSkillCornerTest >> jsonMatchData4039 [
	"Answer metadata for match number 4039."

	^ ReadStream on:
		  '{"referees": [{"first_name": "Anthony", "referee_role": 0, "start_time": "00:00:00", "trackable_object": 11513, "last_name": "Taylor", "end_time": null, "replaced_by": null, "id": 58}], "date_time": "2020-07-02T19:15:00Z", "home_team": {"acronym": "MCI", "id": 40, "short_name": "Manchester City", "name": "Manchester City"}, "away_team": {"acronym": "LIV", "id": 2, "short_name": "Liverpool", "name": "Liverpool Football Club"}, "away_team_kit": {"jersey_color": "#c10021", "name": "home", "season": {"name": "2017/2018", "id": 4, "end_date": "2018-07-31", "start_date": "2017-08-01"}, "team_id": 2, "number_color": "#ffffff", "id": 250}, "home_team_coach": {"first_name": "Pep", "last_name": "Guardiola", "id": 41}, "status": "closed", "pitch_length": 105, "players": [{"injured": false, "own_goal": 0, "last_name": "Mahrez", "goal": 1, "red_card": 0, "number": 26, "id": 9067, "trackable_object": 9077, "team_id": 40, "birthday": "1991-02-21", "end_time": null, "first_name": "Riyad", "player_role": {"acronym": "SUB", "id": 17, "name": "Substitute"}, "start_time": null, "yellow_card": 0, "team_player_id": 6382}, {"injured": false, "own_goal": 0, "last_name": "Takumi", "goal": 0, "red_card": 0, "number": 18, "id": 11773, "trackable_object": 11879, "team_id": 2, "birthday": "1995-01-16", "end_time": null, "first_name": "Minamino", "player_role": {"acronym": "LW", "id": 12, "name": "Left Winger"}, "start_time": "01:24:10", "yellow_card": 0, "team_player_id": 23626}, {"injured": false, "own_goal": 0, "last_name": "Silva", "goal": 0, "red_card": 0, "number": 20, "id": 1326, "trackable_object": 1336, "team_id": 40, "birthday": "1994-08-10", "end_time": null, "first_name": "Bernardo", "player_role": {"acronym": "LW", "id": 12, "name": "Left Winger"}, "start_time": "01:18:08", "yellow_card": 0, "team_player_id": 5119}, {"injured": false, "own_goal": 0, "last_name": "Otamendi", "goal": 0, "red_card": 0, "number": 30, "id": 8029, "trackable_object": 8039, "team_id": 40, "birthday": "1988-02-12", "end_time": null, "first_name": "Nicolas", "player_role": {"acronym": "LCB", "id": 3, "name": "Left Center Back"}, "start_time": "01:17:53", "yellow_card": 0, "team_player_id": 153}, {"injured": false, "own_goal": 0, "last_name": "Williams", "goal": 0, "red_card": 0, "number": 76, "id": 24614, "trackable_object": 25648, "team_id": 2, "birthday": "2001-04-13", "end_time": null, "first_name": "Neco", "player_role": {"acronym": "RWB", "id": 6, "name": "Right Wing Back"}, "start_time": "01:15:23", "yellow_card": 0, "team_player_id": 23530}, {"injured": false, "own_goal": 0, "last_name": "Cancelo", "goal": 0, "red_card": 0, "number": 27, "id": 5056, "trackable_object": 5066, "team_id": 40, "birthday": "1994-05-27", "end_time": null, "first_name": "Joao", "player_role": {"acronym": "RWB", "id": 6, "name": "Right Wing Back"}, "start_time": "01:12:24", "yellow_card": 0, "team_player_id": 20251}, {"injured": false, "own_goal": 1, "last_name": "Oxlade-Chamberlain", "goal": 0, "red_card": 0, "number": 15, "id": 505, "trackable_object": 515, "team_id": 2, "birthday": "1993-08-15", "end_time": null, "first_name": "Alex", "player_role": {"acronym": "SUB", "id": 17, "name": "Substitute"}, "start_time": null, "yellow_card": 0, "team_player_id": 4827}, {"injured": false, "own_goal": 0, "last_name": "Origi", "goal": 0, "red_card": 0, "number": 27, "id": 2782, "trackable_object": 2792, "team_id": 2, "birthday": "1995-04-18", "end_time": null, "first_name": "Divock", "player_role": {"acronym": "CF", "id": 15, "name": "Center Forward"}, "start_time": "01:01:35", "yellow_card": 0, "team_player_id": 6533}, {"injured": false, "own_goal": 0, "last_name": "Keita", "goal": 0, "red_card": 0, "number": 8, "id": 11518, "trackable_object": 11589, "team_id": 2, "birthday": "1995-02-10", "end_time": null, "first_name": "Naby", "player_role": {"acronym": "LM", "id": 9, "name": "Left Midfield"}, "start_time": "01:01:26", "yellow_card": 0, "team_player_id": 6538}, {"injured": false, "own_goal": 0, "last_name": "Elliott", "goal": 0, "red_card": 0, "number": 67, "id": 14022, "trackable_object": 14219, "team_id": 2, "birthday": "2003-04-04", "end_time": null, "first_name": "Harvey", "player_role": {"acronym": "SUB", "id": 17, "name": "Substitute"}, "start_time": null, "yellow_card": 0, "team_player_id": 20387}, {"injured": false, "own_goal": 0, "last_name": "Milner", "goal": 0, "red_card": 0, "number": 7, "id": 4673, "trackable_object": 4683, "team_id": 2, "birthday": "1986-01-04", "end_time": null, "first_name": "James", "player_role": {"acronym": "SUB", "id": 17, "name": "Substitute"}, "start_time": null, "yellow_card": 0, "team_player_id": 721}, {"injured": false, "own_goal": 0, "last_name": "Jones", "goal": 0, "red_card": 0, "number": 48, "id": 11754, "trackable_object": 11855, "team_id": 2, "birthday": "2001-01-30", "end_time": null, "first_name": "Curtis", "player_role": {"acronym": "SUB", "id": 17, "name": "Substitute"}, "start_time": null, "yellow_card": 0, "team_player_id": 5558}, {"injured": false, "own_goal": 0, "last_name": "Adrian", "goal": 0, "red_card": 0, "number": 13, "id": 264, "trackable_object": 274, "team_id": 2, "birthday": "1987-01-03", "end_time": null, "first_name": "", "player_role": {"acronym": "SUB", "id": 17, "name": "Substitute"}, "start_time": null, "yellow_card": 0, "team_player_id": 20243}, {"injured": false, "own_goal": 0, "last_name": "Firmino", "goal": 0, "red_card": 0, "number": 9, "id": 9133, "trackable_object": 9143, "team_id": 2, "birthday": "1991-10-02", "end_time": "01:01:35", "first_name": "Roberto", "player_role": {"acronym": "CF", "id": 15, "name": "Center Forward"}, "start_time": "00:00:00", "yellow_card": 0, "team_player_id": 3966}, {"injured": false, "own_goal": 0, "last_name": "Mane", "goal": 0, "red_card": 0, "number": 10, "id": 9439, "trackable_object": 9449, "team_id": 2, "birthday": "1992-04-10", "end_time": "01:24:10", "first_name": "Sadio", "player_role": {"acronym": "LW", "id": 12, "name": "Left Winger"}, "start_time": "00:00:00", "yellow_card": 0, "team_player_id": 4087}, {"injured": false, "own_goal": 0, "last_name": "Salah", "goal": 0, "red_card": 0, "number": 11, "id": 7735, "trackable_object": 7745, "team_id": 2, "birthday": "1992-06-15", "end_time": null, "first_name": "Mohamed", "player_role": {"acronym": "RW", "id": 13, "name": "Right Winger"}, "start_time": "00:00:00", "yellow_card": 0, "team_player_id": 4828}, {"injured": false, "own_goal": 0, "last_name": "Henderson", "goal": 0, "red_card": 0, "number": 14, "id": 5308, "trackable_object": 5318, "team_id": 2, "birthday": "1990-06-17", "end_time": null, "first_name": "Jordan", "player_role": {"acronym": "RM", "id": 10, "name": "Right Midfield"}, "start_time": "00:00:00", "yellow_card": 1, "team_player_id": 1088}, {"injured": false, "own_goal": 0, "last_name": "Fabinho", "goal": 0, "red_card": 0, "number": 3, "id": 3257, "trackable_object": 3267, "team_id": 2, "birthday": "1993-10-23", "end_time": null, "first_name": "", "player_role": {"acronym": "CM", "id": 8, "name": "Center Midfield"}, "start_time": "00:00:00", "yellow_card": 0, "team_player_id": 6534}, {"injured": false, "own_goal": 0, "last_name": "Wijnaldum", "goal": 0, "red_card": 0, "number": 5, "id": 3837, "trackable_object": 3847, "team_id": 2, "birthday": "1990-11-11", "end_time": "01:01:26", "first_name": "Georginio", "player_role": {"acronym": "LM", "id": 9, "name": "Left Midfield"}, "start_time": "00:00:00", "yellow_card": 0, "team_player_id": 4086}, {"injured": false, "own_goal": 0, "last_name": "Robertson", "goal": 0, "red_card": 0, "number": 26, "id": 841, "trackable_object": 851, "team_id": 2, "birthday": "1994-03-11", "end_time": null, "first_name": "Andrew", "player_role": {"acronym": "LWB", "id": 5, "name": "Left Wing Back"}, "start_time": "00:00:00", "yellow_card": 0, "team_player_id": 5532}, {"injured": false, "own_goal": 0, "last_name": "van Dijk", "goal": 0, "red_card": 0, "number": 4, "id": 10738, "trackable_object": 10748, "team_id": 2, "birthday": "1991-07-08", "end_time": null, "first_name": "Virgil", "player_role": {"acronym": "LCB", "id": 3, "name": "Left Center Back"}, "start_time": "00:00:00", "yellow_card": 0, "team_player_id": 5531}, {"injured": false, "own_goal": 0, "last_name": "Gomez", "goal": 0, "red_card": 0, "number": 12, "id": 11475, "trackable_object": 11537, "team_id": 2, "birthday": "1997-05-23", "end_time": "00:44:08", "first_name": "Joe", "player_role": {"acronym": "RCB", "id": 4, "name": "Right Center Back"}, "start_time": "00:00:00", "yellow_card": 0, "team_player_id": 4825}, {"injured": false, "own_goal": 0, "last_name": "Sterling", "goal": 0, "red_card": 0, "number": 7, "id": 8846, "trackable_object": 8856, "team_id": 40, "birthday": "1994-12-08", "end_time": "01:18:08", "first_name": "Raheem", "player_role": {"acronym": "LW", "id": 12, "name": "Left Winger"}, "start_time": "00:00:00", "yellow_card": 0, "team_player_id": 868}, {"injured": false, "own_goal": 0, "last_name": "Hernandez", "goal": 0, "red_card": 0, "number": 16, "id": 9192, "trackable_object": 9202, "team_id": 40, "birthday": "1996-06-22", "end_time": null, "first_name": "Rodrigo", "player_role": {"acronym": "CM", "id": 8, "name": "Center Midfield"}, "start_time": "00:00:00", "yellow_card": 0, "team_player_id": 20199}, {"injured": false, "own_goal": 0, "last_name": "Jesus", "goal": 0, "red_card": 0, "number": 9, "id": 11500, "trackable_object": 11566, "team_id": 40, "birthday": "1997-04-03", "end_time": "00:57:14", "first_name": "Gabriel", "player_role": {"acronym": "CF", "id": 15, "name": "Center Forward"}, "start_time": "00:00:00", "yellow_card": 0, "team_player_id": 5120}, {"injured": false, "own_goal": 0, "last_name": "de Bruyne", "goal": 1, "red_card": 0, "number": 17, "id": 5811, "trackable_object": 5821, "team_id": 40, "birthday": "1991-06-28", "end_time": null, "first_name": "Kevin", "player_role": {"acronym": "RM", "id": 10, "name": "Right Midfield"}, "start_time": "00:00:00", "yellow_card": 0, "team_player_id": 2322}, {"injured": false, "own_goal": 0, "last_name": "G\u00fcndogan", "goal": 0, "red_card": 0, "number": 8, "id": 4450, "trackable_object": 4460, "team_id": 40, "birthday": "1990-10-24", "end_time": null, "first_name": "Ilkay", "player_role": {"acronym": "LM", "id": 9, "name": "Left Midfield"}, "start_time": "00:00:00", "yellow_card": 0, "team_player_id": 4782}, {"injured": false, "own_goal": 0, "last_name": "Mendy", "goal": 0, "red_card": 0, "number": 22, "id": 1292, "trackable_object": 1302, "team_id": 40, "birthday": "1994-07-17", "end_time": null, "first_name": "Benjamin", "player_role": {"acronym": "LWB", "id": 5, "name": "Left Wing Back"}, "start_time": "00:00:00", "yellow_card": 1, "team_player_id": 6660}, {"injured": false, "own_goal": 0, "last_name": "Garcia", "goal": 0, "red_card": 0, "number": 50, "id": 23104, "trackable_object": 24015, "team_id": 40, "birthday": "2001-01-09", "end_time": null, "first_name": "Eric", "player_role": {"acronym": "RCB", "id": 4, "name": "Right Center Back"}, "start_time": "00:00:00", "yellow_card": 0, "team_player_id": 20201}, {"injured": false, "own_goal": 0, "last_name": "Laporte", "goal": 0, "red_card": 0, "number": 14, "id": 1142, "trackable_object": 1152, "team_id": 40, "birthday": "1994-05-27", "end_time": "01:17:53", "first_name": "Aymeric", "player_role": {"acronym": "LCB", "id": 3, "name": "Left Center Back"}, "start_time": "00:00:00", "yellow_card": 0, "team_player_id": 5536}, {"injured": false, "own_goal": 0, "last_name": "Walker", "goal": 0, "red_card": 0, "number": 2, "id": 6027, "trackable_object": 6037, "team_id": 40, "birthday": "1990-05-28", "end_time": "01:12:24", "first_name": "Kyle", "player_role": {"acronym": "RWB", "id": 6, "name": "Right Wing Back"}, "start_time": "00:00:00", "yellow_card": 0, "team_player_id": 5067}, {"injured": false, "own_goal": 0, "last_name": "Ederson", "goal": 0, "red_card": 0, "number": 31, "id": 2924, "trackable_object": 2934, "team_id": 40, "birthday": "1993-08-17", "end_time": null, "first_name": "", "player_role": {"acronym": "GK", "id": 0, "name": "Goalkeeper"}, "start_time": "00:00:00", "yellow_card": 0, "team_player_id": 4776}, {"injured": false, "own_goal": 0, "last_name": "Alexander-Arnold", "goal": 0, "red_card": 0, "number": 66, "id": 11746, "trackable_object": 11847, "team_id": 2, "birthday": "1998-10-07", "end_time": "01:15:23", "first_name": "Trent", "player_role": {"acronym": "RWB", "id": 6, "name": "Right Wing Back"}, "start_time": "00:00:00", "yellow_card": 0, "team_player_id": 5529}, {"injured": false, "own_goal": 0, "last_name": "Becker", "goal": 0, "red_card": 0, "number": 1, "id": 11499, "trackable_object": 11565, "team_id": 2, "birthday": "1992-10-02", "end_time": null, "first_name": "Alisson Ramses", "player_role": {"acronym": "GK", "id": 0, "name": "Goalkeeper"}, "start_time": "00:00:00", "yellow_card": 0, "team_player_id": 6530}, {"injured": false, "own_goal": 0, "last_name": "Zinchenko", "goal": 0, "red_card": 0, "number": 11, "id": 11590, "trackable_object": 11671, "team_id": 40, "birthday": "1996-12-15", "end_time": null, "first_name": "Oleksandr", "player_role": {"acronym": "SUB", "id": 17, "name": "Substitute"}, "start_time": null, "yellow_card": 0, "team_player_id": 5117}, {"injured": false, "own_goal": 0, "last_name": "Silva", "goal": 0, "red_card": 0, "number": 21, "id": 2491, "trackable_object": 2501, "team_id": 40, "birthday": "1986-01-08", "end_time": null, "first_name": "David", "player_role": {"acronym": "SUB", "id": 17, "name": "Substitute"}, "start_time": null, "yellow_card": 0, "team_player_id": 3541}, {"injured": false, "own_goal": 0, "last_name": "Doyle", "goal": 0, "red_card": 0, "number": 69, "id": 24324, "trackable_object": 25334, "team_id": 40, "birthday": "2001-10-17", "end_time": null, "first_name": "Thomas", "player_role": {"acronym": "SUB", "id": 17, "name": "Substitute"}, "start_time": null, "yellow_card": 0, "team_player_id": 22935}, {"injured": false, "own_goal": 0, "last_name": "Stones", "goal": 0, "red_card": 0, "number": 5, "id": 5192, "trackable_object": 5202, "team_id": 40, "birthday": "1994-05-28", "end_time": null, "first_name": "John", "player_role": {"acronym": "SUB", "id": 17, "name": "Substitute"}, "start_time": null, "yellow_card": 0, "team_player_id": 4089}, {"injured": false, "own_goal": 0, "last_name": "Bravo", "goal": 0, "red_card": 0, "number": 1, "id": 1937, "trackable_object": 1947, "team_id": 40, "birthday": "1983-04-13", "end_time": null, "first_name": "Claudio", "player_role": {"acronym": "SUB", "id": 17, "name": "Substitute"}, "start_time": null, "yellow_card": 0, "team_player_id": 4088}, {"injured": false, "own_goal": 0, "last_name": "Foden", "goal": 1, "red_card": 0, "number": 47, "id": 11591, "trackable_object": 11672, "team_id": 40, "birthday": "2000-05-28", "end_time": null, "first_name": "Phil", "player_role": {"acronym": "RW", "id": 13, "name": "Right Winger"}, "start_time": "00:00:00", "yellow_card": 0, "team_player_id": 5118}], "away_team_coach": {"first_name": "J\u00fcrgen", "last_name": "Klopp", "id": 49}, "ball": {"trackable_object": 55}, "pitch_width": 68, "competition_edition": {"season": {"name": "2019/2020", "id": 6, "end_date": "2020-07-31", "start_date": "2019-08-01"}, "id": 79, "competition": {"id": 1, "name": "Premier League", "area": "ENG"}, "name": "Premier League 2019-2020"}, "stadium": {"city": "Manchester", "capacity": 46708, "id": 70, "name": "Etihad"}, "home_team_kit": {"jersey_color": "#00fff5", "name": "home", "season": {"name": "2019/2020", "id": 6, "end_date": "2020-07-31", "start_date": "2019-08-01"}, "team_id": 40, "number_color": "#ffffff", "id": 1317}, "competition_round": {"potential_overtime": false, "round_number": 32, "id": 38, "name": "Round 32"}, "away_team_score": 0, "id": 4039, "home_team_score": 5}'
]

{ #category : 'fixtures' }
STSkillCornerTest >> jsonStructuredDataTwoFramesFrom4039 [
	"Answer a chunk with two frames splitted from match number 4039."

	^ ReadStream on: '[
  {
    "possession": {
      "trackable_object": null,
      "group": "home team"
    },
    "frame": 59812,
    "data": [
      {
        "y": 14.0149269204,
        "x": -9.03983078165,
        "z": 0.0286309869824,
        "trackable_object": 55,
        "track_id": -446
      },
      {
        "y": -12.4565515518,
        "x": -24.8415599551,
        "trackable_object": 25648,
        "track_id": 8171
      },
      {
        "y": 2.8644580614,
        "x": -27.0938751584,
        "trackable_object": 9077,
        "track_id": 8165
      },
      {
        "y": -14.5703672,
        "x": -4.00493526459,
        "trackable_object": 7745,
        "track_id": 8174
      },
      {
        "y": 7.62039484297,
        "x": -5.72335372652,
        "trackable_object": 2792,
        "track_id": 8173
      },
      {
        "y": 11.1461325146,
        "x": -18.8727474213,
        "trackable_object": 9449,
        "track_id": 8167
      },
      {
        "y": 5.24895261583,
        "x": -20.6743159521,
        "trackable_object": 11589,
        "track_id": 8162
      },
      {
        "y": -1.75558910483,
        "x": -18.1471233368,
        "trackable_object": 11513,
        "track_id": 8141
      },
      {
        "y": -4.19028015364,
        "x": -24.1662842887,
        "trackable_object": 3267,
        "track_id": 8166
      },
      {
        "y": -5.41968434198,
        "x": -11.455620584,
        "trackable_object": 4460,
        "track_id": 8145
      },
      {
        "y": 9.9902997244,
        "x": -20.4544313522,
        "trackable_object": 9202,
        "track_id": 8146
      },
      {
        "y": 1.35207298256,
        "x": -22.2540036156,
        "trackable_object": 515,
        "track_id": 8140
      },
      {
        "y": 15.6162680217,
        "x": -24.8598234994,
        "trackable_object": 851,
        "track_id": 8160
      },
      {
        "y": 8.12655794053,
        "x": -24.3663008554,
        "trackable_object": 10748,
        "track_id": 8158
      },
      {
        "y": 8.38238879613,
        "x": -25.8122021811,
        "trackable_object": 11672,
        "track_id": 8164
      },
      {
        "y": -4.51280593872,
        "x": -19.8935892923,
        "trackable_object": 5318,
        "track_id": 8159
      }
    ],
    "period": 2,
    "time": "79:55.00"
  },
  {
    "possession": {
      "trackable_object": null,
      "group": "home team"
    },
    "frame": 59813,
    "data": [
      {
        "y": 14.3648403531,
        "x": -8.05475466829,
        "z": 0.0334028181461,
        "trackable_object": 55,
        "track_id": -446
      },
      {
        "y": -12.3027290617,
        "x": -24.643860817,
        "trackable_object": 25648,
        "track_id": 8171
      },
      {
        "y": 2.93605337824,
        "x": -26.9486576262,
        "trackable_object": 9077,
        "track_id": 8165
      },
      {
        "y": -14.4822901998,
        "x": -4.28629442624,
        "trackable_object": 7745,
        "track_id": 8174
      },
      {
        "y": 8.19198315484,
        "x": -5.43389215923,
        "trackable_object": 2792,
        "track_id": 8173
      },
      {
        "y": 11.1562469573,
        "x": -18.5840880984,
        "trackable_object": 9449,
        "track_id": 8167
      },
      {
        "y": 5.49755300794,
        "x": -20.4097935813,
        "trackable_object": 11589,
        "track_id": 8162
      },
      {
        "y": -1.7134348892,
        "x": -18.2412345523,
        "trackable_object": 11513,
        "track_id": 8141
      },
      {
        "y": -4.02561621439,
        "x": -24.081084206,
        "trackable_object": 3267,
        "track_id": 8166
      },
      {
        "y": -5.39453465598,
        "x": -11.2965058372,
        "trackable_object": 4460,
        "track_id": 8145
      },
      {
        "y": 10.0159293583,
        "x": -20.5188403357,
        "trackable_object": 9202,
        "track_id": 8146
      },
      {
        "y": 1.34027919883,
        "x": -22.0296686263,
        "trackable_object": 515,
        "track_id": 8140
      },
      {
        "y": 15.7963069734,
        "x": -24.8559266953,
        "trackable_object": 851,
        "track_id": 8160
      },
      {
        "y": 8.20049596968,
        "x": -24.2309907277,
        "trackable_object": 10748,
        "track_id": 8158
      },
      {
        "y": 8.71862779345,
        "x": -25.8463525318,
        "trackable_object": 11672,
        "track_id": 8164
      },
      {
        "y": -4.42544292268,
        "x": -19.8695913042,
        "trackable_object": 5318,
        "track_id": 8159
      }
    ],
    "period": 2,
    "time": "79:55.10"
  }
]'
]

{ #category : 'running' }
STSkillCornerTest >> setUp [

	super setUp.
	matchData2068 := STSkillCornerMatchData on: self jsonMatchData2068.
	matchData4039 := STSkillCornerMatchData on: self jsonMatchData4039.
	match4039Converter := STSkillCornerConverter
		                      matchData: self jsonMatchData4039
		                      structuredData:
		                      self jsonStructuredDataTwoFramesFrom4039
]

{ #category : 'tests' }
STSkillCornerTest >> testAwaytTeam [

	self assert: matchData2068 awayTeamId equals: 139.
	self
		assert: (matchData2068 teamNameAt: matchData2068 awayTeamId)
		equals: 'Juventus'
]

{ #category : 'running' }
STSkillCornerTest >> testBall [

	self assert: matchData2068 ballId equals: 55
]

{ #category : 'tests' }
STSkillCornerTest >> testBallPosition [

	| reader |
	reader := STSoccerDocumentReader parse:
		          match4039Converter writeWholeDocument.
	reader currentFrameIndex: 1.
	self
		assert: reader currentSoccerFrame ball position
		equals: -9.0 @ 14.0
]

{ #category : 'tests' }
STSkillCornerTest >> testBallPosssession [

	| reader |
	reader := STSoccerDocumentReader parse:
		          match4039Converter writeWholeDocument.
	reader currentFrameIndex: 1.
	self
		assert: reader currentSoccerFrame ball owningTeam teamName
		equals: (matchData4039 teamNameAt: matchData4039 homeTeamId)
]

{ #category : 'tests' }
STSkillCornerTest >> testHomeTeam [

	self assert: matchData2068 homeTeamId equals: 145.
	self
		assert: (matchData2068 teamNameAt: matchData2068 homeTeamId)
		equals: 'Inter'
]

{ #category : 'running' }
STSkillCornerTest >> testPitch [

	self assert: matchData2068 pitch extent equals: 105 @ 68
]

{ #category : 'tests' }
STSkillCornerTest >> testPlayerTracks [

	| skillCornerFrame |
	skillCornerFrame := STSkillCornerFrame
		                    jsonFrame:
			                    (NeoJSONReader on:
				                     self jsonStructuredDataTwoFramesFrom4039)
				                    next first
		                    matchData: matchData4039.
	self assert: skillCornerFrame playerTracks size equals: 14.
	self
		assert: (skillCornerFrame leftmostPlayer at: 'number')
		equals: 26.
	self assert: skillCornerFrame isNotEmptyHomeTeam.
	self assert: skillCornerFrame isNotEmptyAwayTeam
]

{ #category : 'running' }
STSkillCornerTest >> testPlayers [

	self assert: matchData2068 playersById size equals: 43
]

{ #category : 'tests' }
STSkillCornerTest >> testValid [

	self
		shouldnt: [
		STSoccerDocumentReader parse: match4039Converter writeWholeDocument ]
		raise: XMLValidationException
]
