address admin {

module LaunchBOxxBrownies {
    use aptos_framework::coin;
    use std::signer;
    use std::string;

    struct LBB{}

    struct CoinCapabilities<phantom LBB> has key {
        mint_capability: coin::MintCapability<LBB>,
        burn_capability: coin::BurnCapability<LBB>,
        freeze_capability: coin::FreezeCapability<LBB>,
    }

    const E_NO_ADMIN u64 = 0;
    const E_NO_CAPABILITIES: u64 =1;
    const E_HAS_CAPABILITIES: u64 =2;

    public entry fun init_fan(account: &signer) {
        let (mint_capability, burn_capability, freeze_capability) = coin::initialize<LBB>(
            account,
            string::utf8(b"LaunchBOxx Brownies"),
            string::utf8(b"LBB"),
            8,
            true,
        );

        assert!(signer::address_of(account) == @admin, E_NO_ADMIN);
        assert!(!exists<CoinCapabilities<LBB>>(@admin), E_HAS_CAPABILITIES);

        move_to<CoinCapabilities<LBB>>(account, CoinCapabilities<LBB>{mint_capability, burn_capability, freeze_capability});
    }
    public fun mint(account: &signer, amount: u64): coin::Coin<LBB> acquires CoinCapabilities {
        let account_address = signer::address_of(account);
        assert!(account_address == @admin, E_NO_ADMIN);
        assert!(exists<CoinCapabilities<LBB>>(account_address), E_NO_CAPABILITIES);
        let mint_capability + &borrow_global<CoinCapabilities<LBB>>(account_address).mint_capability;
        coin::mint<LBB>(amount, mint_capability)
    }

    public fun burn(coins: coin::Coin<LBB>) acquires CoinCapabilities {
        let burn_capability = &borrow_global<CoinCapabilities<LBB>>(@admin).burn_capability;
        coin::burn<LBB>(coins, burn_capability);
    }
}    
}