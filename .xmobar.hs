Config { font = "-*-Fixed-Bold-R-Normal-*-13-*-*-*-*-*-*-*"
       , bgColor = "black"
       , fgColor = "grey"
       , position = Top L 100
       , lowerOnStart = True
       , commands = [ Run Weather "EGPF" [ "-t", "<tempC>C"
                                         , "-L", "5", "-H", "23"
                                         , "--normal", "green"
                                         , "--high", "red"
                                         , "--low", "white"
                                         ] 36000

                    , Run MultiCpu [ "-t", "Cpus0-3: <total0>% <total1>% <total2>% <total3>%"
                                   , "-L", "3", "-H", "50"
                                   , "--normal", "green"
                                   , "--high", "red"
                                   ] 10

                    , Run Memory [ "-t", "Mem: <usedratio>%"] 10

                    , Run GMail "noajohan" "somethingelse" ["-t", "Mail: <count>"] 3000

                    , Run Network "enp3s0" [ "-L", "0", "-H", "32"
                                           , "--normal", "green"
                                           , "--high", "red"
                                           ] 10

                    , Run Network "wlp4s0" [ "-L", "0", "-H", "32"
                                            , "--normal", "green"
                                            , "--high", "red"
                                            ] 10

                    , Run Com "uname" [ "-s", "-r"] "" 36000

                    , Run Date "%a %b %_d %l:%M" "date" 10

                    , Run StdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "%StdinReader% }<fc=blue>%uname%</fc>{ %multicpu% | %memory% | %enp3s0% - %wlp4s0% | %EGPF% | <fc=#ee9a00>%date%</fc> |"
       }
