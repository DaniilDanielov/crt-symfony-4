<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20211225205517 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('DROP SEQUENCE messenger_messages_id_seq CASCADE');
        $this->addSql('CREATE SEQUENCE ingredients_id_seq INCREMENT BY 1 MINVALUE 1 START 1');
        $this->addSql('CREATE TABLE ingredients (id INT NOT NULL, name VARCHAR(255) NOT NULL, price INT DEFAULT NULL, PRIMARY KEY(id))');
        $this->addSql('CREATE TABLE ingredients_pizzas (ingredients_id INT NOT NULL, pizzas_id INT NOT NULL, PRIMARY KEY(ingredients_id, pizzas_id))');
        $this->addSql('CREATE INDEX IDX_9011F51C3EC4DCE ON ingredients_pizzas (ingredients_id)');
        $this->addSql('CREATE INDEX IDX_9011F51C7F778084 ON ingredients_pizzas (pizzas_id)');
        $this->addSql('ALTER TABLE ingredients_pizzas ADD CONSTRAINT FK_9011F51C3EC4DCE FOREIGN KEY (ingredients_id) REFERENCES ingredients (id) ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE ingredients_pizzas ADD CONSTRAINT FK_9011F51C7F778084 FOREIGN KEY (pizzas_id) REFERENCES pizzas (id) ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('DROP TABLE messenger_messages');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE ingredients_pizzas DROP CONSTRAINT FK_9011F51C3EC4DCE');
        $this->addSql('DROP SEQUENCE ingredients_id_seq CASCADE');
        $this->addSql('CREATE SEQUENCE messenger_messages_id_seq INCREMENT BY 1 MINVALUE 1 START 1');
        $this->addSql('CREATE TABLE messenger_messages (id BIGSERIAL NOT NULL, body TEXT NOT NULL, headers TEXT NOT NULL, queue_name VARCHAR(255) NOT NULL, created_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL, available_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL, delivered_at TIMESTAMP(0) WITHOUT TIME ZONE DEFAULT NULL, PRIMARY KEY(id))');
        $this->addSql('CREATE INDEX idx_75ea56e0fb7336f0 ON messenger_messages (queue_name)');
        $this->addSql('CREATE INDEX idx_75ea56e016ba31db ON messenger_messages (delivered_at)');
        $this->addSql('CREATE INDEX idx_75ea56e0e3bd61ce ON messenger_messages (available_at)');
        $this->addSql('DROP TABLE ingredients');
        $this->addSql('DROP TABLE ingredients_pizzas');
    }
}
