
(define (domain almacen_logistico)
  (:requirements :strips :typing)
  (:types zona caja)

  (:predicates
    (robot_en ?z - zona)
    (caja_en ?c - caja ?z - zona)
    (carretilla_en ?z - zona)

    (abierta ?z - zona)
    (cerrada ?z - zona)

    (pesada ?c - caja)
    (ligera ?c - caja)

    (obstaculo ?from - zona ?to - zona)
    (libre ?from - zona ?to - zona)

    (con_carretilla)
    (sin_carretilla)

    (adyacente ?z1 ?z2 - zona)
  )

  ;; Acción para mover el robot
  (:action moverse
    :parameters (?from - zona ?to - zona)
    :precondition (and (robot_en ?from) (adyacente ?from ?to) (libre ?from ?to))
    :effect (and (robot_en ?to) (not (robot_en ?from)))
  )

  ;; Acción para recoger la carretilla
  (:action coger_carretilla
    :parameters (?z - zona)
    :precondition (and (robot_en ?z) (carretilla_en ?z) (sin_carretilla) (abierta ?z))
    :effect (and (con_carretilla) (not (sin_carretilla)) (not (carretilla_en ?z)))
  )

  ;; Acción para soltar la carretilla
  (:action soltar_carretilla
    :parameters (?z - zona)
    :precondition (and (robot_en ?z) (con_carretilla) (abierta ?z))
    :effect (and (sin_carretilla) (not (con_carretilla)) (carretilla_en ?z))
  )

  ;; Acción para abrir una zona adyacente que está cerrada
  (:action abrir_zona
    :parameters (?z - zona)
    :precondition (and (robot_en ?z) (cerrada ?z))
    :effect (and (abierta ?z) (not (cerrada ?z)))
  )

  ;; Acción para apartar un obstáculo de un camino entre dos zonas
  (:action apartar_obstaculo
    :parameters (?from - zona ?to - zona)
    :precondition (and (robot_en ?from) (obstaculo ?from ?to) (adyacente ?from ?to))
    :effect (and (libre ?from ?to) (not (obstaculo ?from ?to)))
  )

  ;; Acción para transportar una caja ligera
  (:action transportar_caja_ligera
    :parameters (?from - zona ?to - zona ?c - caja)
    :precondition (and (robot_en ?from) (caja_en ?c ?from) (ligera ?c) (sin_carretilla) (adyacente ?from ?to) (abierta ?from) (abierta ?to) (libre ?from ?to))
    :effect (and (robot_en ?to) (caja_en ?c ?to) (not (robot_en ?from)) (not (caja_en ?c ?from)))
  )

  ;; Acción para transportar una caja pesada (requiere carretilla)
  (:action transportar_caja_pesada
    :parameters (?from - zona ?to - zona ?c - caja)
    :precondition (and (robot_en ?from) (caja_en ?c ?from) (pesada ?c) (con_carretilla) (adyacente ?from ?to) (abierta ?from) (abierta ?to) (libre ?from ?to))
    :effect (and (robot_en ?to) (caja_en ?c ?to) (not (robot_en ?from)) (not (caja_en ?c ?from)))
  )
)
