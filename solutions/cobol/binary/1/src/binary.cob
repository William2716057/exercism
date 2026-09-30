       IDENTIFICATION DIVISION.
       PROGRAM-ID. BINARY.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-BINARY                PIC X(60).
       01 WS-RESULT                PIC 9999.
       01 WS-ERROR                 PIC X(60).
       01 WS-LEN                   PIC 99.
       01 WS-IDX                   PIC 99.
       01 WS-MSG-DIGITS.
           05 FILLER PIC X(27) VALUE "error: a number containing ".
           05 FILLER PIC X(28) VALUE "non-binary digits is invalid".
       01 WS-MSG-CHARS.
           05 FILLER PIC X(27) VALUE "error: a number containing ".
           05 FILLER PIC X(32) VALUE "non-binary characters is invalid".

       PROCEDURE DIVISION.

       DECIMAL.
           MOVE 0 TO WS-RESULT
           MOVE SPACES TO WS-ERROR
           COMPUTE WS-LEN =
               FUNCTION LENGTH(FUNCTION TRIM(WS-BINARY TRAILING))

           PERFORM VARYING WS-IDX FROM 1 BY 1
                   UNTIL WS-IDX > WS-LEN OR WS-ERROR NOT = SPACES
               EVALUATE WS-BINARY(WS-IDX:1)
                   WHEN "0"
                       COMPUTE WS-RESULT = WS-RESULT * 2
                   WHEN "1"
                       COMPUTE WS-RESULT = WS-RESULT * 2 + 1
                   WHEN OTHER
                       IF WS-BINARY(WS-IDX:1) IS NUMERIC
                           MOVE WS-MSG-DIGITS TO WS-ERROR
                       ELSE
                           MOVE WS-MSG-CHARS TO WS-ERROR
                       END-IF
               END-EVALUATE
           END-PERFORM

           IF WS-ERROR NOT = SPACES
               MOVE 0 TO WS-RESULT
           END-IF. 