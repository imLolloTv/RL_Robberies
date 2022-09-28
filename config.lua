Config = {}

Config.Language = "en"

Config.Rapine = {
    ["Groove"] = { -- Robbery example, you can create infinite robberies simply changing every item
        Coords = vector3(-43.336540222168, -1748.3553466797, 29.421016693115), -- Robbery Coords
        MaxDistance = 15, -- Max distance (After this Meters the robbery will be canceled)
        Guadagno = 10000, -- Money Earning
        Minuti = 0.1, -- Minutes you need to Rob
        Polizia = 2, -- Policeman needed
        Label = "24/7 Groove Street", -- Label in marker and in Police Notify
        Cooldown = 30, -- Cooldown to rob this store again
    }
}

Config.PoliceJobName = 'police' --  Your police job name

Config.CooldownPlayer = 30 -- Cooldown to rob a store again (Based of ESX License/Steam)

Config.Lang = { 
    ["en"] = {
        Distance = "You are escaped, you lost the Money",
        OpeningSafe = "You're opening the safe",
        Robbery = "Robbery",
        SafeAlreadyOpened = "The safe is already opened",
        YouHaveCooldown = "You can robbery ever <b>%s minutes</b>, You can robbery after <b>%s minutes</b>",
        YouEarned = "You have earned <b>$%s",
        NoSuchPolice = "There is not enough Police",
        RobberyInProgress = "Robbery in progress at <b>%s",
    },

    ["it"] = {
        Distance = "Ti sei allontanato, hai perso la refurtiva",
        OpeningSafe = "Stai aprendo la cassaforte",
        Robbery = "Rapina",
        SafeAlreadyOpened = "La cassaforte è già aperta",
        YouHaveCooldown = "Puoi fare una rapina ogni <b>%s Minuti</b>, Ti mancano <b>%s minuti</b>",
        YouEarned = "Hai guadagnato <b>%s",
        NoSuchPolice = "Non c'è abbastanza polizia",
        RobberyInProgress = "Rapina in corso a <b>%s",
    },
}