using DrWatson
@quickactivate "youtube-julia-refrigeration"

using CoolProp

T_L = 4 + 273
T_H = 32 + 273

fluids = [
    "R134a",
    "R290",
    "R718",
    "R22",
    "R717"
]

for fluid in fluids
    P_cond = PropsSI("P", "T", T_H, "Q", 0, fluid)
    P_evap = PropsSI("P", "T", T_L, "Q", 1, fluid)

    h3 = PropsSI("H", "T", T_H, "Q", 1, fluid)
    s3 = PropsSI("S", "T", T_H, "Q", 1, fluid)

    h4 = PropsSI("H", "P", P_cond, "Q", 0, fluid)
    s4 = PropsSI("S", "P", P_cond, "Q", 0, fluid)

    s1 = s4
    h1 = PropsSI("H", "P", P_evap, "S", s1, fluid)

    s2 = s3
    h2 = PropsSI("H", "P", P_evap, "S", s2, fluid)

    qL = h2 - h1
    qH = h3 - h4
    wliq = qH - qL
    COP = qL / wliq

    println("Fluid: $fluid")
    println("COP: $COP")
    println("Cond. pressure [bar]: $(1e-5*P_cond)")
    println("Evap. pressure [bar]: $(1e-5*P_evap)")
    println()
end
