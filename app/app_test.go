package app

import (
	"context"
	"os"
	"testing"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/dynamodb"
	"github.com/shamaton/dynamo-actions-test/app/config"
)

func TestDynamo(t *testing.T) {
	ctx := context.Background()

	v2, err := config.GetConfig(ctx)
	if err != nil {
		t.Fatal(err)
	}

	ep := os.Getenv("DYNAMO_ENDPOINT")
	t.Log("endpoint:", ep)

	if ep == "" {
		ep = "http://localhost:8000"
		t.Log("set endpoint:", ep)
	}

	cfg := aws.Config{
		Region:   aws.String(v2.Region),
		Endpoint: aws.String(ep),
	}

	api := dynamodb.New(session.Must(session.NewSession()), &cfg)

	input := &dynamodb.ListTablesInput{}
	output, err := api.ListTables(input)
	if err != nil {
		t.Fatal(err)
	}
	t.Log(output)
}
