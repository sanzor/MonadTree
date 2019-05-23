module State where 
    import Control.Monad 
    import System.Directory
   
    newtype State s a = State {run::s->(a,s)} 

    instance Functor (State s) where
        fmap=Control.Monad.liftM
    instance Applicative (State s) where
        pure=return
        (<*>)=Control.Monad.ap
    instance Monad (State s) where
        return a= State $ \k->(a,k) 
        (>>=) m f=State $ \s -> let (a,s')=run m s in
            run (f a) s'
    
    data Env=Env{
        envName::String,
        fileNames::[String]
    }
    instance Show Env where 
        show Env{envName=x,fileNames=xs} = "{ envName:"++x++" , files: ["++foldr (\t y-> t++","++y) "" xs ++"] }"
      
    initEnv::IO Env
    initEnv=do
        name<- getLine
        names<- getCurrentDirectory>>=listDirectory
        return Env{envName=name,fileNames=names}
    
    
    readEnv::State Env Env
    readEnv=State $ \_ ->do
        return value

   -- changeEnvName::String->State Env ()

   -- getEnvFileLengths::State Env [Int]
   

   https://www.reddit.com/r/haskellquestions/comments/7piqvg/get_and_put_from_the_state_monad_still_confuse_me/


    
    
   
   
  
     

 
   