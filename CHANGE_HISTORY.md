# bds-etc
## cmd/geth/flags.go
Modify SetupServerArgs method to support some new commands about kafka related startup commands.
```
KafkaEndpointFlag = cli.StringFlag{
    Name:  "kafka.endpoint",
    Usage: "Enable kafka",
}
```

## core/config.go

```
// kafka endpoint
var KafkaEndpoint    string
```

## internal/eth/api.go

```
//send block data to kafka by number
func (s *PublicBlockChainAPI) SendBlockByNumber(blockNr rpc.BlockNumber, fullTx bool) 

//send block data to kafka by hash
func (s *PublicBlockChainAPI) SendBlockByHash(ctx context.Context, blockHash common.Hash, fullTx bool) 

//send batch block data to kafka by start and end number
func (s *PublicBlockChainAPI) SendBatchBlockByNumber(blockStart rpc.BlockNumber, blockEnd rpc.BlockNumber) 

```

## eth/api.go
implement sendBlockToKafka method

```
func (s *PublicBlockChainAPI) SendBlockToKafka(blk *types.Block, rcps types.Receipts) error {
	err := s.bc.NewWriteDataToKafka(blk, rcps)
	if err != nil {
		return err
	}
	return nil
}
```

## core/blockchain.go
The main process to send data to kafka:

```
//the core function implement 
func (bc *BlockChain) NewWriteDataToKafka(blk *types.Block, rcps []*types.Receipt)
```

## common/httputil/rest_client.go
Add new file:
implement the http rest client
