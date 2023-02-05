local L = BigWigs:NewBossLocale("Algeth'ar Academy Trash", "ruRU")
if not L then return end
if L then
	L.custom_on_recruiter_autotalk = "Авторазговор"
	--L.custom_on_recruiter_autotalk_desc = "Instantly pledge to the Dragonflight Recruiters for a buff."
	L.critical_strike = "+5% Критический удар"
	L.haste = "+5% Скорость"
	L.mastery = "+Искусность"
	L.versatility = "+5% Универсальность"
	L.healing_taken = "+10% Получаемое исцеление"

	--L.vexamus_warmup_trigger = "created a powerful construct named Vexamus"
	--L.overgrown_ancient_warmup_trigger = "Ichistrasz! There is too much life magic"
	--L.crawth_warmup_trigger = "At least we know that works. Watch yourselves."

	L.corrupted_manafiend = "Оскверненный манадемон"
	L.spellbound_battleaxe = "Зачарованный боевой топор"
	L.spellbound_scepter = "Зачарованный скипетр"
	L.arcane_ravager = "Чародейский опустошитель"
	L.unruly_textbook = "Хаотичный учебник"
	L.guardian_sentry = "Охранник"
	L.alpha_eagle = "Орел-вожак"
	L.vile_lasher = "Мерзкий плеточник"
	L.algethar_echoknight = "Алгет'арский рыцарь эха"
	L.spectral_invoker = "Алгет'арская заклинательница"
	L.ethereal_restorer = "Алгет'арский целитель"
end
