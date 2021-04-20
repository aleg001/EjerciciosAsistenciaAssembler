/*
*----------------------------------------
* Ejercicio en clase 20 de abril: programación
* ---------------------------------------
* UNIVERSIDAD DEL VALLE DE GUATEMALA
* CC3054 - Organización de computadoras
* y Assembler
* Adaptado y escrito por: Alejandro Gomez
* ---------------------------------------
Para dar seguimiento al proceso de vacunación, el MSPS ha solicitado a los estudiantes del Curso CC3054 realizar un programa que permita Ingresar su nombre, número de dpi y edad.
Si la persona es mayor de 70 años, se le indica que pertenece a la fase 2A
Si la persona es menor a 70 años, pero mayor a 60, se indicará que pertenece a la fase 2B
Si la persona se encuentra entre 18 y 59 años, entonces se indicará que pertenece a la fase 3
Si la edad es menor a 18 años, se indica que no se puede vacunar
*----------------------------------------*/

.text
.align 2
.global main
.type main,%function

main:
	stmfd sp!, {lr}	/* SP = R13 link register */

	ldr r0, =string1
	bl puts
	/*lee la edad */
	ldr r0,=formato
	ldr r1,=edad
	bl scanf

	/*carga la edad en r1*/
	ldr r1,=edad
	ldr r1,[r1]

	/*compara si esta en el rango de edades*/
	cmp r1,#18
	bge mayordiesocho
	/*es menor de 18 fuera de rango*/
	blt noVacuna


mayordiesocho:
	cmp r1,#19
	ble enRango

// Se define para
mayorsesenta:
    cmp r1, #69
    ble enRangoAntesDeSetenta

mayorsetenta:
    cmp r1, #100
    ble FaseDosA

menoradiesnueve:
    cmp r1, #19
    ble noVacuna

FaseDosA:
    ldr r0,= mensaje1
    bl puts


enRangoAntesDeSetenta:
    ldr r0,=mensaje2
    bl puts

enRango:
	ldr r0,=mensaje3
	bl puts

noVacuna:
    ldr r0,=mensaje4
    bl puts
    b fin


	/* salida correcta */
fin:	mov r0, #0
	mov r3, #0
	ldmfd sp!, {lr}	/* R13 = SP */
	bx lr


.data
.align 2
string1:
	.asciz "Ingrese su edad: "
edad:
	.word 0
formato:
	.asciz "%d"

// Mayor a 70
mensaje1:
	.asciz "Por ser mayor a 70 años, es fase 2A"

// Mayor a 60, menor a 70.
mensaje2:
	.asciz "Por tener mas de 60 y menos de 70, es fase 2B"

// Igual/mayor a 18 e igual/mayor a 59
mensaje3:
	.asciz "Por tener entre 18 y 59, se encuentra en fase 3"

// Menor a 18 
mensaje4:
	.asciz "Lo siento, usted es menor a 18, no hay vacunas... :("

