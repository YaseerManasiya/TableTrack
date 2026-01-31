<?php

namespace App\Console\Commands;

use App\Models\Branch;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Database\Seeders\OrderSeeder;

class OrderSeedCommand extends Command
{

    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'order:seed';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Seed orders for the current day';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $startTime = microtime(true);
        $startMemory = memory_get_usage();

        $this->info('----------------------------------------');
        $this->info('Starting order seeding for today...');

        try {
            DB::enableQueryLog();

            $branches = Branch::all();

            if ($branches->isEmpty()) {
                $this->warn('No branches found. Skipping order seeding.');
                return Command::SUCCESS;
            }

            $orderSeeder = new OrderSeeder();

            foreach ($branches as $branch) {
                $this->info("Seeding orders for branch: {$branch->name} (ID: {$branch->id})");
                
                try {
                    $orderSeeder->seedOrdersForToday($branch);
                    $this->info("✓ Successfully seeded orders for branch: {$branch->name}");
                } catch (\Exception $e) {
                    $this->error("✗ Failed to seed orders for branch: {$branch->name}");
                    $this->error("Error: " . $e->getMessage());
                    logger()->error("Order seeding failed for branch {$branch->id}: " . $e->getMessage());
                }
            }

            $executionTime = round(microtime(true) - $startTime, 2);
            $memoryUsed = round((memory_get_usage() - $startMemory) / 1024 / 1024, 2);
            $queryCount = count(DB::getQueryLog());

            $this->line("<fg=green>✓</> <fg=blue>Completed in</> <fg=yellow>{$executionTime}s</> <fg=white>|</> <fg=yellow>{$memoryUsed}MB</> <fg=white>|</> <fg=yellow>{$queryCount}</> <fg=blue>queries</>");
            
            return Command::SUCCESS;
        } catch (\Exception $e) {
            $this->error('An error occurred while seeding orders: ' . $e->getMessage());
            logger()->error('Order seeding command failed: ' . $e->getMessage());
            return Command::FAILURE;
        }
    }
}



