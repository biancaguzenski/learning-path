## 1) system calls

- Chamada de sistema é um evento no qual uma aplicação faz uma solicitação ao sistema operacional, como por exemplo, acesso ao disco rígido para recuperar um documento.
- Para efetuar o comando, o SO sai do modo usuário e entra no modo kernel, onde tem permissão de agir diretamente sobre o hardware.
- Instrução trap é essa interrupção de software que a aplicação causa no SO (um printf, por exemplo) 
- Mecanismo: 1. aplicação faz a chamada ao sistema - programa interrompido 2. modo usuário -> modo kernel 3. sistema salva o conteudo dos registradores [pilha] (seu ponto de parada) 4.execução da ação gerada pelo systme call 5. modo kernel -> modo usuário 6. restaura o conteudo dos registradores 7. aplicação obtem a resposta
- API que esconde a complexidade do syscall do usuário> win32, posix, java api
- Nos sistemas POSIX e similares, as chamadas de sistema mais usadas são close, execve, fork, wait, kill, open, read, write, clone, nice, exit, send, receive, signal e ioctl. Os sistemas operacionais atuais tem centenas de chamadas de sistema. Por exemplo, o Linux tem quase 300 chamadas de sistema diferentes. O FreeBSD tem praticamente o mesmo número (quase 330).

* Interrupções: outra forma de interrupção, mas a nível de hardware (causada por um dispositivo s/o ou clock
