Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

Lang = {
    ["no_weight"]           =   "Hai le tasce piene",
    ["item_controll"]       =   "Emh, Ti manca qualcosa!",
    ["can_i_cancel"]        =   "Hai annulato l'azione in corso!",
    ["job_count_controll"]  =   "Non ci sono abbastanza sbirri in città, vatti a prendere una birra e torna dopo!",
    ["onlyjob"]             =   "Non hai il permesso, vai altrove prima che sia troppo tardi",
    ["only_at_one_time"]    =   "Non puoi raccogliere adesso torna piu tardi, sarai piu fortunato"
}

_ConfigS = {


    ["drugs_harvesting"] = {       --nome univoco della tabella, puoi creare tutti le tabelle che vuoi senza un reale limite

        point = {               --coordinate dei marker, puoi creare tutti i punti che vuoi senza un reale limite

        ["1"]     = vector3(2231.5473632812,5576.8208007812,53.983123779297),
        ["2"]     = vector3(2223.2297363281,5577.5498046875,53.835830688477),
        ["3"]     = vector3(2215.1433105469,5577.5776367188,53.829444885254),

        },

        require = {

            item_controll = true,                      --se in questa azione bisogna controllare se il player ha o potrà prendere un determinato item
            list_item_controll = {
                remove  = {
                    enable = false,                     --se in questa azione bisogna rimuovere un item
                    name    = "",               --nome del item da rimuovere
                    count   = 0                        --quantita del item da rimuovere (se non vuoi usare il math.random basta toglierlo e scrivere il numero)
                },              
                add = {
                    enable = true,                        --se in questa azione bisogna aggiungere un item
                    name = "medikit",                     --nome del item da aggiungere
                    count = math.random(1,7)              --quantita del item da aggiungere (se non vuoi usare il math.random basta toglierlo e scrivere il numero)
                },  
            },

            job_count_controll = true,         -- se vuoi controllare se deve esserci un tot di un determinato job online per poter eseguire l'azione
            list_job_count_controll = {

                ["police"]      = 1,           -- nome del job e numero minimo di player online con quel determinato job
                ["sceriffi"]    = 1
            },

            onlyjob = false,                    --se vuoi che questo punto sia solo di un determiato gruppo/singolo job
            whitelist_job = {

                ["cartello"]    = true,         --nome del job
                ["mafia1"]      = true, 

            },

            only_at_one_time = true,           --se vuoi che si possa eseguire l azione solo ad una determinata fascia oraria
            your_time_zone = 2,                --il tuo fuso orario se il tuo host è in italia lascia 2
            whitelist_time = {

               ["start"] = {
                   ["hour"]     = 8            -- 0,1,2,3,4,5 ecc..
               },       
               ["stop"]  = {
                    ["hour"]     = 12,         -- 0,1,2,3,4,5 ecc..      
                },
            }
        },

        misc = {

            marker_config = {
                show_marker = true,                     --se vuoi che il marker sia visibile

                render_distance = 5.0,                  --la distanza in cui vuoi che si inizi a vedere il marker
                interaction_distance = 4.0,             --la distanza in cui vuoi che si possa interagire con il marker

                text_notify = true,                     --se vuoi la notifica in alto a sinistra

                text = "Premi [~g~E~w~] Raccogliere",    --testo della notifica

                rgb = vector3(255, 255, 255),           --colore del marker
                type = 20,                              --tipo di marker
                scale = vector3(0.7, 0.7, 0.7),         --dimensioni del marker
            },

            animation = {
   
                enable = true,                                              --se vuoi che il player faccia un animazione durante l azione
                lib = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",  --dict/lib del animazione
                anim = "weed_crouch_checkingleaves_idle_03_inspector",      --nome del animazione
                time = 10,                                                  --durata del animazione espressa in secondi
                can_i_cancel = false,                                       --se l animazione puo essere interrotta
                key_cancel = Keys["BACKSPACE"],                             --tasto con la quale poter interrompere l animazione
                disablekey = {                                              --tasti disabilitati durante l animzione ( per i RegisterKeyMapping usate l export presente nel client)
                    Keys["X"],
                    Keys["F1"],
                    Keys["F2"],
                    Keys["F3"],
                    Keys["F5"],
                }
            }
        }
    },
    ["drugs_process"] = {       --nome univoco della tabella

        point = {               --coordinate dei marker, puoi creare tutti i punti che vuoi senza un reale limite

            ["1"]     = vector3(2200.4228515625,5615.1508789062,53.76953125),  

        },

        require = {

            item_controll = true,                      --se in questa azione bisogna controllare se il player ha o potrà prendere un determinato item
            list_item_controll = {
                remove  = {
                    enable = true,                     --se in questa azione bisogna rimuovere un item
                    name    = "medikit",               --nome del item da rimuovere
                    count   = 2                        --quantita del item da rimuovere (se non vuoi usare il math.random basta toglierlo e scrivere il numero)
                },              
                add = {
                    enable = true,                      --se in questa azione bisogna aggiungere un item
                    name = "bandage",                   --nome del item da aggiungere
                    count = math.random(1,4)            --quantita del item da aggiungere (se non vuoi usare il math.random basta toglierlo e scrivere il numero)
                },  
            },

            job_count_controll = true,         -- se vuoi controllare se deve esserci un tot di un determinato job online per poter eseguire l'azione
            list_job_count_controll = {

                ["police"]      = 1,           -- nome del job e numero minimo di player online con quel determinato job
                ["sceriffi"]    = 1
            },

            onlyjob = false,                    --se vuoi che questo punto sia solo di un determiato gruppo/singolo job
            whitelist_job = {

                ["cartello"]    = true,         --nome del job
                ["mafia1"]      = true, 

            },

            only_at_one_time = true,           --se vuoi che si possa eseguire l azione solo ad una determinata fascia oraria
            your_time_zone = 2,                --il tuo fuso orario se il tuo host è in italia lascia 2
            whitelist_time = {

            ["start"] = {
                ["hour"]     = 8            -- 0,1,2,3,4,5 ecc..
            },       
            ["stop"]  = {
                    ["hour"]     = 12,         -- 0,1,2,3,4,5 ecc..      
                },
            }
        },

        misc = {

            marker_config = {
                show_marker = true,                     --se vuoi che il marker sia visibile

                render_distance = 5.0,                  --la distanza in cui vuoi che si inizi a vedere il marker
                interaction_distance = 4.0,             --la distanza in cui vuoi che si possa interagire con il marker

                text_notify = true,                     --se vuoi la notifica in alto a sinistra

                text = "Premi [~g~E~w~] Processare",    --testo della notifica

                rgb = vector3(255, 255, 255),           --colore del marker
                type = 20,                              --tipo di marker
                scale = vector3(0.7, 0.7, 0.7),         --dimensioni del marker
            },

            animation = {

                enable = true,                                              --se vuoi che il player faccia un animazione durante l azione
                lib = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",  --dict/lib del animazione
                anim = "weed_crouch_checkingleaves_idle_03_inspector",      --nome del animazione
                time = 10,                                                  --durata del animazione espressa in secondi
                can_i_cancel = false,                                       --se l animazione puo essere interrotta
                key_cancel = Keys["BACKSPACE"],                             --tasto con la quale poter interrompere l animazione
                disablekey = {                                              --tasti disabilitati durante l animzione ( per i RegisterKeyMapping usate l export presente nel client)
                    Keys["X"],
                    Keys["F1"],
                    Keys["F2"],
                    Keys["F3"],
                    Keys["F5"],
                }
            }
        }
    },
    ["drugs_selling"] = {       --nome univoco della tabella

        point = {               --coordinate dei marker, puoi creare tutti i punti che vuoi senza un reale limite

              ["1"]     = vector3(2215.75,5631.45703125,56.138931274414),  

        },

        require = {

            item_controll = true,                      --se in questa azione bisogna controllare se il player ha o potrà prendere un determinato item
            list_item_controll = {
                remove  = {
                    enable = true,                     --se in questa azione bisogna rimuovere un item
                    name    = "bandage",               --nome del item da rimuovere
                    count   = 2                        --quantita del item da rimuovere (se non vuoi usare il math.random basta toglierlo e scrivere il numero)
                },              
                add = {
                    enable = true,                      --se in questa azione bisogna aggiungere un item
                    name = "money",                     --nome del item da aggiungere
                    count = math.random(1000,2000)      --quantita del item da aggiungere (se non vuoi usare il math.random basta toglierlo e scrivere il numero)
                },  
            },

            job_count_controll = true,         -- se vuoi controllare se deve esserci un tot di un determinato job online per poter eseguire l'azione
            list_job_count_controll = {

                ["police"]      = 1,           -- nome del job e numero minimo di player online con quel determinato job
                ["sceriffi"]    = 1
            },

            onlyjob = false,                    --se vuoi che questo punto sia solo di un determiato gruppo/singolo job
            whitelist_job = {

                ["cartello"]    = true,         --nome del job
                ["mafia1"]      = true, 

            },

            only_at_one_time = true,           --se vuoi che si possa eseguire l azione solo ad una determinata fascia oraria
            your_time_zone = 2,                --il tuo fuso orario se il tuo host è in italia lascia 2
            whitelist_time = {

               ["start"] = {
                   ["hour"]     = 8            -- 0,1,2,3,4,5 ecc..
               },       
               ["stop"]  = {
                    ["hour"]     = 12,         -- 0,1,2,3,4,5 ecc..      
                },
            }
        },

        misc = {

            marker_config = {
                show_marker = true,                     --se vuoi che il marker sia visibile

                render_distance = 5.0,                  --la distanza in cui vuoi che si inizi a vedere il marker
                interaction_distance = 4.0,             --la distanza in cui vuoi che si possa interagire con il marker

                text_notify = true,                     --se vuoi la notifica in alto a sinistra

                text = "Premi [~g~E~w~] Vendere",    --testo della notifica

                rgb = vector3(255, 255, 255),           --colore del marker
                type = 20,                              --tipo di marker
                scale = vector3(0.7, 0.7, 0.7),         --dimensioni del marker
            },

            animation = {
   
                enable = true,                                              --se vuoi che il player faccia un animazione durante l azione
                lib = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",  --dict/lib del animazione
                anim = "weed_crouch_checkingleaves_idle_03_inspector",      --nome del animazione
                time = 10,                                                  --durata del animazione espressa in secondi
                can_i_cancel = false,                                       --se l animazione puo essere interrotta
                key_cancel = Keys["BACKSPACE"],                             --tasto con la quale poter interrompere l animazione
                disablekey = {                                              --tasti disabilitati durante l animzione ( per i RegisterKeyMapping usate l export presente nel client)
                    Keys["X"],
                    Keys["F1"],
                    Keys["F2"],
                    Keys["F3"],
                    Keys["F5"],
                }
            }
        }
    },

}

