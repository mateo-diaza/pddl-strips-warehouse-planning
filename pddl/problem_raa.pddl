
(define (problem gestion_almacen)
  (:domain almacen_logistico)
  (:objects
    A B C D - zona
    caja1 caja2 caja3 - caja
  )
  (:init
    ;; Estado Inicial

    ;; Situación del robot, cajas y carretilla
    (robot_en B)
    (caja_en caja1 D)
    (caja_en caja3 A)
    (caja_en caja2 C)
    (carretilla_en C)

    ;; Características del robot
    (sin_carretilla)

    ;; Características de las cajas
    (ligera caja1)
    (ligera caja2)
    (pesada caja3)

    ;; Características de las zonas
    (cerrada A)
    (abierta B)
    (cerrada C)
    (abierta D)

    ;; Definición de adyacencias
    (adyacente A B)
    (adyacente A D)

    (adyacente B A)
    (adyacente B C)
    (adyacente B D)

    (adyacente C A)
    (adyacente C B)
    (adyacente C D)

    (adyacente D A)

    ;; Características de adyacencias
    (obstaculo A B) 
    (obstaculo A D)
    (obstaculo B D)
    (obstaculo C B)
    (obstaculo C D)

    (libre B A)
    (libre B C)
    (libre C A)
    (libre D A)

  )
  (:goal (and (caja_en caja1 C) (caja_en caja2 B) (caja_en caja3 C)))
)
