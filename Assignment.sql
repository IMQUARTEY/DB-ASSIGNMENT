 ---QUESTION 1
SELECT
 COUNT(u_id)
FROM
 users;
  
  --QUESTION 2
SELECT
COUNT(transfer_id)
FROM
transferS
WHERE send_amount_currency='CFA';

--QUESTION 3
SELECT
COUNT(DISTINCT u_id)
FROM
 transfers
WHERE send_amount_currency='CFA';

--QUESTION 4
SELECT
  COUNT (atx_id)
FROM
  agent_transactions
WHERE 
  EXTRACT(YEAR FROM WHEN CREATED)=2018
GROUP BY
  EXTRACT (MONTH FROM when_created); 
  
  --QUESTION 5
WITH agent_withdrawers AS
(SELECT COUNT (agent_id)
AS net_withdrawers
FROM agent_transactions
HAVING COUNT(amount)
IN (SELECT COUNT(amount) FROM agent_transactions WHERE amount >-1
AND amount !=0 HAVING COUNT (amount) >1 AND amount !=0)))
SELECT net_withdrawers
FROM agent_withdrawer;

--QUESTION 6
SELECT COUNT(atx.amount) AS "atx volume city summary" ,ag.city
FROM agent_transactions AS atx LEFT OUTER JION agents AS ag ON
atx.atx_id=ag.agent_id
WHERE atx.when_created BETWEEN NOW()::DATE-EXTRACT(DOW FROM NOW())::INTEGER-7
AND NOW()::DATE-EXTRACT(DOW FROM NOW())::INTEGER
GROUP BY ag.city;

--QUESTION 7
SELECT COUNT(atx.amount) AS "atx volume",COUNT(ag.city) AS "city",COUNT(ag.country) AS "country"
FROM agent_transactions AS atx INNER JOIN agents AS AG ON
atx.atx_id =ag.agent_id
GROUP BY ag.country;

--QUESTION 8
SELECT transfers.kind AS kind,wallets.ledger_location AS Country,
SUM (transfers.send_amount_scalar) AS Volume FROM transfers
INNER JOIN wallets ON transfers.source_wallet_id = wallets.wallets_id
WHERE (transactions.when_created >(NOW() -INTERVAL '1 week'))
GROUP BY wallets.ledger_location, transfers.kind;

--QUESTION 9
SELECT 
COUNT(transfers.source_wallet_is)
AS Unique_sanders
COUNT(transfer_id)
AS Transaction_Count,transfers.kind
AS Transfer_kind,
wallets.ledger_location AS Country,
SUM(transfers.send_amount_scalar) AS Volume FROM transfers
INNER JOIN wallets ON transfers.source_wallet_id= wallets.wallet_id
WHERE(transfers.when_created>(NOW() - INTERVALS'1 week'))
GROUP BY wallets.ledgers_location,transfers.kind;

--QUESTION 10
SELECT tn.send_amount_scalar,tn.source_wallets_id,w.wallets_id
FROM transfers AS tn INNER JOIN wallets AS w ON tn.transfer_id =w.wallet_id
WHERE tn.send_amount_scalar > 10000000 AND
(tn.send_amount_currency = 'CFA' AND  tn.when.created >
CURRENT_DATE-INTERVAL '1 month');
