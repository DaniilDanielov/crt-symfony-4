<?php
namespace App\Message;

    class OrderMessage
{

    private $id;
    private $context;

        /**
         * @param int $id
         * @param array $context
         */
    public function __construct(int $id,array $context=[])
    {
        $this->id = $id;
        $this->context = $context;
    }
        /**
         * @return int
         */
        public function getId(): int
        {
            return $this->id;
        }

        /**
         * @param int $id
         */
        public function setId(int $id): void
        {
            $this->id = $id;
        }

        /**
         * @return array
         */
        public function getContext(): array
        {
            return $this->context;
        }

        /**
         * @param array $context
         */
        public function setContext(array $context): void
        {
            $this->context = $context;
        }

}