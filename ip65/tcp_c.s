.include "../inc/common.i"

.export _tcp_listen
.export _tcp_connect
.export _tcp_close
.export _tcp_recv_buf
.export _tcp_recv_len
.export _tcp_send
.export _tcp_send_keep_alive

.import tcp_listen
.import tcp_connect
.import tcp_close
.import tcp_inbound_data_ptr
.import tcp_inbound_data_length
.import tcp_send
.import tcp_send_keep_alive

.import tcp_callback
.import tcp_connect_ip
.import tcp_send_data_len

.import popax, popeax
.importzp ptr1, sreg

_tcp_listen:
  stax tcp_callback
  jsr popax
  jsr tcp_listen
  ldx #$00
  txa
  rol
  rts

_tcp_connect:
  stax tcp_callback
  jsr popax
  stax ptr1
  jsr popeax
  stax tcp_connect_ip
  ldax sreg
  stax tcp_connect_ip+2
  ldax ptr1
  jsr tcp_connect
  ldx #$00
  txa
  rol
  rts

_tcp_close:
  jsr tcp_close
  ldx #$00
  txa
  rol
  rts

_tcp_recv_buf := tcp_inbound_data_ptr

_tcp_recv_len := tcp_inbound_data_length

_tcp_send:
  stax tcp_send_data_len
  jsr popax
  jsr tcp_send
  ldx #$00
  txa
  rol
  rts

_tcp_send_keep_alive:
  jsr tcp_send_keep_alive
  ldx #$00
  txa
  rol
  rts