	.option nopic
	.attribute arch, "rv32i2p1_m2p0_f2p2_d2p2_v1p0_zicsr2p0_zve32f1p0_zve32x1p0_zve64d1p0_zve64f1p0_zve64x1p0_zvl128b1p0_zvl32b1p0_zvl64b1p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	sw	s0,12(sp)
	addi	s0,sp,16

ADDRESS1	= 0x10000000
ADDRESS2	= 0x10010000
ADDRESS3	= 0x10020000
ADDRESS4 	= 0x10030000

	li				a2,65536

# fill memory with values #
	li				a0,0					
	li				a1,ADDRESS1				
.L1:
	fcvt.s.w		fa0,a0					
	addi			a0,a0,1					
	fsw				fa0,(a1)				
	addi			a1,a1,4					
	bne				a2,a0,.L1

# VLEN = 16 + ADDRESS1 #
	# set vector length and element width #
	li				a0,16				
	vsetvli 		t0,a0,e32			

	# set distance between 2 vectors #
	slli			a0,a0,2

	# load 2 vectors and add them #
	li				a1,ADDRESS1
	vle32.v 		v1,(a1)
	add				a1,a1,a0		
	vle32.v 		v2,(a1)
	vfadd.vv		v1,v2,v1

	# write back vector #
	li				a1,ADDRESS1
	vse32.v			v1,(a1)

# VLEN = 16 + ADDRESS2 #
	# set vector length and element width #
	li				a0,16				
	vsetvli 		t0,a0,e32			

	# set distance between 2 vectors #
	slli			a0,a0,2

	# load 2 vectors and add them #
	li				a1,ADDRESS2
	vle32.v 		v1,(a1)
	add				a1,a1,a0		
	vle32.v 		v2,(a1)
	vfadd.vv		v1,v2,v1

	# write back vector #
	li				a1,ADDRESS2
	vse32.v			v1,(a1)

# VLEN = 16 + ADDRESS3 #
	# set vector length and element width #
	li				a0,16				
	vsetvli 		t0,a0,e32			

	# set distance between 2 vectors #
	slli			a0,a0,2

	# load 2 vectors and add them #
	li				a1,ADDRESS3
	vle32.v 		v1,(a1)
	add				a1,a1,a0		
	vle32.v 		v2,(a1)
	vfadd.vv		v1,v2,v1

	# write back vector #
	li				a1,ADDRESS3
	vse32.v			v1,(a1)

# VLEN = 16 + ADDRESS4 #
	# set vector length and element width #
	li				a0,16				
	vsetvli 		t0,a0,e32			

	# set distance between 2 vectors #
	slli			a0,a0,2

	# load 2 vectors and add them #
	li				a1,ADDRESS4
	vle32.v 		v1,(a1)
	add				a1,a1,a0		
	vle32.v 		v2,(a1)
	vfadd.vv		v1,v2,v1

	# write back vector #
	li				a1,ADDRESS4
	vse32.v			v1,(a1)

# VLEN = 8 + ADDRESS1 #
	# set vector length and element width #
	li				a0,8				
	vsetvli 		t0,a0,e32			

	# set distance between 2 vectors #
	slli			a0,a0,2

	# load 2 vectors and add them #
	li				a1,ADDRESS1
	vle32.v 		v1,(a1)
	add				a1,a1,a0		
	vle32.v 		v2,(a1)
	vfadd.vv		v1,v2,v1

	# write back vector #
	li				a1,ADDRESS1
	vse32.v			v1,(a1)

# VLEN = 8 + ADDRESS2 #
	# set vector length and element width #
	li				a0,8				
	vsetvli 		t0,a0,e32			

	# set distance between 2 vectors #
	slli			a0,a0,2

	# load 2 vectors and add them #
	li				a1,ADDRESS2
	vle32.v 		v1,(a1)
	add				a1,a1,a0		
	vle32.v 		v2,(a1)
	vfadd.vv		v1,v2,v1

	# write back vector #
	li				a1,ADDRESS2
	vse32.v			v1,(a1)

# VLEN = 8 + ADDRESS3 #
	# set vector length and element width #
	li				a0,8				
	vsetvli 		t0,a0,e32			

	# set distance between 2 vectors #
	slli			a0,a0,2

	# load 2 vectors and add them #
	li				a1,ADDRESS3
	vle32.v 		v1,(a1)
	add				a1,a1,a0		
	vle32.v 		v2,(a1)
	vfadd.vv		v1,v2,v1

	# write back vector #
	li				a1,ADDRESS3
	vse32.v			v1,(a1)

# VLEN = 8 + ADDRESS4 #
	# set vector length and element width #
	li				a0,8				
	vsetvli 		t0,a0,e32			

	# set distance between 2 vectors #
	slli			a0,a0,2

	# load 2 vectors and add them #
	li				a1,ADDRESS4
	vle32.v 		v1,(a1)
	add				a1,a1,a0		
	vle32.v 		v2,(a1)
	vfadd.vv		v1,v2,v1

	# write back vector #
	li				a1,ADDRESS4
	vse32.v			v1,(a1)

	li	a5,0
	mv	a0,a5
	lw	s0,12(sp)
	addi	sp,sp,16
	jr	ra
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
