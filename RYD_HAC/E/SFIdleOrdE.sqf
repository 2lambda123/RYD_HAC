waitUntil {sleep 1; not (isNil "RydHQE_SpecForG")};

while {not (isNull RydHQE)} do
	{
	_pos = getPosATL (vehicle leaderHQE);

		{
		_isBad = false;
		if (isNull _x) then
			{
			_isBad = true
			}
		else
			{
			if not (alive (leader _x)) then
				{
				_isBad = true
				}
			else
				{
				_isBad = _x getVariable [("Resting" + (str _x)),false];
				if not (_isBad) then
					{
					_isBad = _x getVariable [("Busy" + (str _x)),false]
					}
				}
			};

		if not (_isBad) then
			{
			_unitG = _x;
			[_unitG] call RYD_WPdel;

			_pos = getPosATL (vehicle leaderHQE);
			_posX = (_pos select 0) + (random 200) - 100;
			_posY = (_pos select 1) + (random 200) - 100;

			_isWater = surfaceIsWater [_posX,_posY];
			_cnt = 0;

			while {((_isWater) or (_cnt > 100))} do
				{
				_cnt = _cnt + 1;
				_posX = (_pos select 0) + (random 200) - 100;
				_posY = (_pos select 1) + (random 200) - 100;
				_isWater = surfaceIsWater [_posX,_posY]
				};

			if not (_isWater) then 
				{
				_UL = leader _unitG;
				RydHQE_VCDone = true;
				if (isPlayer _UL) then {[_UL,leaderHQE] spawn VoiceComm;sleep 3;waituntil {sleep 0.1;(RydHQE_VCDone)}};

				_tasks = _UL getVariable ["HACAddedTasks",[]];

				if ((count _tasks) == 0) then
					{
					if (isPlayer _UL) then
						{
						_task = [_UL,["Guard HQ.", "Guard", ""],[_posX,_posY]] call RYD_AddTask
						}
					};

				_wp = [_unitG,[_posX,_posY],"HOLD","AWARE","RED","NORMAL"] call RYD_WPadd
				}
			}
		}
	foreach RydHQE_SpecForG;

	waitUntil
		{
		sleep 30;

		_nPos = getPosATL (vehicle leaderHQE);

		((_nPos distance _pos) > 10)
		}
	};