.text
.globl encode
.globl decode

// encode(char *dst, const char *src, size_t rails)
encode:
        mov     w3, w2              
        mov     x2, #0              
.Lenc_len:
        ldrb    w9, [x1, x2]
        cbz     w9, .Lenc_len_done  
        add     x2, x2, #1
        b       .Lenc_len
.Lenc_len_done:

        cmp     x3, #1
        b.le    .Lenc_copy_only

        sub     x7, x3, #1
        lsl     x7, x7, #1          
        mov     x6, #0              
        mov     x4, #0              

.Lenc_outer:
        cmp     x4, x3
        b.ge    .Lenc_done
        mov     x5, #0             

.Lenc_inner:
        cmp     x5, x2
        b.ge    .Lenc_inner_done

        udiv    x9, x5, x7
        msub    x8, x9, x7, x5      
        cmp     x8, x3
        b.lt    .Lenc_down
        sub     x10, x7, x8         
        b       .Lenc_check
.Lenc_down:
        mov     x10, x8             
.Lenc_check:
        cmp     x10, x4             
        b.ne    .Lenc_skip

        ldrb    w9, [x1, x5]        
        strb    w9, [x0, x6]        
        add     x6, x6, #1         

.Lenc_skip:
        add     x5, x5, #1
        b       .Lenc_inner

.Lenc_inner_done:
        add     x4, x4, #1
        b       .Lenc_outer

.Lenc_done:
        strb    wzr, [x0, x2]       
        ret

.Lenc_copy_only:
        mov     x5, #0
.Lenc_copy_loop:
        cmp     x5, x2
        b.ge    .Lenc_copy_done
        ldrb    w9, [x1, x5]
        strb    w9, [x0, x5]
        add     x5, x5, #1
        b       .Lenc_copy_loop
.Lenc_copy_done:
        strb    wzr, [x0, x2]       
        ret

// decode(char *dst, const char *src, size_t rails)
decode:
        mov     w3, w2              
        mov     x2, #0              
.Ldec_len:
        ldrb    w9, [x1, x2]
        cbz     w9, .Ldec_len_done
        add     x2, x2, #1
        b       .Ldec_len
.Ldec_len_done:

        cmp     x3, #1
        b.le    .Ldec_copy_only

        sub     x7, x3, #1
        lsl     x7, x7, #1          
        mov     x6, #0              
        mov     x4, #0              

.Ldec_outer:
        cmp     x4, x3
        b.ge    .Ldec_done
        mov     x5, #0              

.Ldec_inner:
        cmp     x5, x2
        b.ge    .Ldec_inner_done

        udiv    x9, x5, x7
        msub    x8, x9, x7, x5      
        cmp     x8, x3
        b.lt    .Ldec_down
        sub     x10, x7, x8         
        b       .Ldec_check
.Ldec_down:
        mov     x10, x8             
.Ldec_check:
        cmp     x10, x4             
        b.ne    .Ldec_skip

        ldrb    w9, [x1, x6]        
        strb    w9, [x0, x5]        
        add     x6, x6, #1          

.Ldec_skip:
        add     x5, x5, #1
        b       .Ldec_inner

.Ldec_inner_done:
        add     x4, x4, #1
        b       .Ldec_outer

.Ldec_done:
        strb    wzr, [x0, x2]       
        ret

.Ldec_copy_only:
        mov     x5, #0
.Ldec_copy_loop:
        cmp     x5, x2
        b.ge    .Ldec_copy_done
        ldrb    w9, [x1, x5]
        strb    w9, [x0, x5]
        add     x5, x5, #1
        b       .Ldec_copy_loop
.Ldec_copy_done:
        strb    wzr, [x0, x2]       
        ret