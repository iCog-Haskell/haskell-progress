module BST
    ( BST
    , bstLeft
    , bstRight
    , bstValue
    , empty
    , fromList
    , insert
    , singleton
    , toList
    ) where

data BST a = EmptyTree | Node a (BST a) (BST a) deriving (Eq, Show)

bstLeft :: BST a -> Maybe (BST a)
bstLeft tree = case tree of EmptyTree -> Nothing
                            (Node _ left _) -> Just left

bstRight :: BST a -> Maybe (BST a)
bstRight tree = case tree of EmptyTree -> Nothing
                             (Node _ _ right) -> Just right

bstValue :: BST a -> Maybe a
bstValue EmptyTree = Nothing
bstValue (Node a _ _) = Just a

empty :: BST a
empty = EmptyTree

fromList :: Ord a => [a] -> BST a
fromList xs = foldl (\acc x -> insert x acc) EmptyTree xs

insert :: Ord a => a -> BST a -> BST a
insert x EmptyTree = Node x EmptyTree EmptyTree
insert x (Node a left right)
    | x > a = Node a left (insert x right) 
    | x <= a = Node a (insert x left) right

singleton :: a -> BST a
singleton x = Node x EmptyTree EmptyTree

toList :: BST a -> [a]
toList EmptyTree = []
toList (Node a left right) = toList left ++ [a] ++ toList right
