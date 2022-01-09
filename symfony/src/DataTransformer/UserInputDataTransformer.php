<?php

namespace App\DataTransformer;

use ApiPlatform\Core\DataTransformer\DataTransformerInterface;
use App\Dto\UserInput;
use App\Entity\User;
use ApiPlatform\Core\Serializer\AbstractItemNormalizer;
use App\Entity\Book;


final class UserInputDataTransformer implements DataTransformerInterface
{

    /**
     * @param $object
     * @param string $to
     * @param array $context
     * @return UserInput|void
     * {@inheritdoc}
     */

    public function transform($object, string $to, array $context = []): User
    {
        $user = new User();
        $user
            ->setUsername($object->getUsername())
            ->setPassword(password_hash($object->getPassword(),PASSWORD_BCRYPT) );
        return $user;
    }

    /**
     * {@inheritdoc}
     */
    public function supportsTransformation($data, string $to, array $context = []): bool
    {
        if ($data instanceof User) {
            return false;
        }

        return User::class === $to && null !== ($context['input']['class'] ?? null);
    }
}